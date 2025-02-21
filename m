Return-Path: <linux-kernel+bounces-526473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A396FA3FF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245B419C2915
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112342512FB;
	Fri, 21 Feb 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="nZfDONwA"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6641F2C56
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164116; cv=none; b=BY2mRu9cvFOrCTlrtlJtaBd3t9SPlWGMbRIu7GqZyzZAtd/S1B90wlyayHlMHQ9wZFdLcbfNnL+bOHr6NKR+INMg0ZqVcSX2SqlLFCZutua4raYajX0oZ3b0YFboGFOHzl53/uJC0LRV93sK7S/YBBZQe+TYxYOP8aHx7p9b31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164116; c=relaxed/simple;
	bh=zTNRvaXssq/gJT25Wr9fqcI96nvvXb5oYejMTSf24vM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=cb5A6Nng6YfqvsFKUX4loZ+yTtPeCpD9Pe8BccAuGvKWRr4GQLUoZo3FSc6IqQhiW5jtzyxD1KDl0VDCTC09Vjj4V7G7DUPosTGezMX6JPuumhlSBv0aQOelvVwGp1UxhSydo1JvBZPmpbjvtAXYlRXWlITDUB19KF07vCbraww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=nZfDONwA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f441791e40so3966172a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1740164113; x=1740768913; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4d6uQVUeeZgznwA3p1q8tL13Il1lBkBvDJFuqttDEGc=;
        b=nZfDONwAialxovWGSYQaIEzkR3OAbKU2ihUqC6ZPgNNHIyUQ20IhZJTj0SWwLrf3zc
         HMl4/p8H8hwOCmfYQOh8sJG8BuHWh4Bb1lDD3nfcxtj8FRIkeJ6/czMsRd0OJ3jWlUFI
         zYj+WVmObQNoluAKgZKPxeqE1JgncqZSq/Kf/w/VOiHyRmTLgA1Z06HV0CE3qCnke72o
         iD+3QrSuP1LqaijiJeBAhMEYlYCVD1z2Ee5UU4eKVMmQLC+CeJm7qMHtD0iLrtgaqaog
         4CdfN0s4czBxfL9mRxbn0NDpobjiN7UIjnIdLRiWpW1ADrjWf7co+NFEMj2JiFfSPVeb
         AC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164113; x=1740768913;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4d6uQVUeeZgznwA3p1q8tL13Il1lBkBvDJFuqttDEGc=;
        b=rb+lh3M7hYx9aeT7Jy5XfgSr2jwQSv+Rdl+GsNUAe8TTJ8S+QAsYs+qDcDv1+XXJJ9
         esuybTl3GIESf/mlP+YXk0qLLznnc4HoVmkc4WBpNpbH/LYLebrLCxEKv3yw08RpmxoO
         LrFKgF+2FAYbwLbcZQLkFJ2kN/813aAogz0jci+eEJWHJgc6T5MnXj71bhwLtLUR4gvT
         tSe8qq/8/+unQQn8A3ozLHQuK6GipT9EZ5DavNQyIP9ZE3gFECTMhgq6n4i2FyNgxDsI
         ugSYf4abEIKQx3kNHxvzNYuoQpuslbsUrYlLVz5dFgTps2TQ9ZZHhRw0aRqv+/Gzv4A5
         q/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4oqEkWlHYGN+MTUyOGH7lvQmUqXURizpwOnnoUgu3u26VCY6OZrWZpjyw9aV9JwQmSgY9l8prsB5Tok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJF7vUuZepRZZoTu867ZhLHyPzKTXDoLlYwth/Gp88cWJZwVA0
	awDws0cVPEqXGPq5ilrmgHiRSLJA6v2NH+RocJHKGD/LbF58ETXywUa/dq1BUtiqM8F0zSZNMui
	CrbQ=
X-Gm-Gg: ASbGncvD2yVXALtBnkJcSDnEDhbHczoCwpiDFQ+I7wLKqwmWjt00y2RTpBaobB01mWt
	lfrbFQHabh0CcA2eU2ZhYd5hcJNztnNtzUWUOJdm+uXqYh5sRMNyC0XhRSLK+dp9MRnXnDKiL/M
	1IrZEhaZkBvifh4/s3nIxTeCo8R6iUjQrf1o04fynYVXu6xqlSc7Ozp8khxVj4mwQIvWwmof838
	5M0ZUBXVaRkuiDfjxffU39O49SiUH6KVSAYd5fzE2xsDdqTSTTIIKiF4fJ01e7IM++eQsQOf3FM
	JpXw+R7yGV5m/dKsMjboRJDHQ3+EZVqvZhcQRYj6pdyUAn4IoNy+Y0EPURDQzV2mOHoeBJiYP0U
	=
X-Google-Smtp-Source: AGHT+IGIjUyLPQ2s1c3R37+ZrPel+kYybizImuQCQ0nwg9t2lK52jt/j411nr/IJFmgSVcm1Fa3+Ng==
X-Received: by 2002:a17:90b:3e8a:b0:2f1:4715:5987 with SMTP id 98e67ed59e1d1-2fce86ae503mr6974270a91.9.1740164112605;
        Fri, 21 Feb 2025 10:55:12 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d82csm1918425a91.10.2025.02.21.10.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:55:11 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <216AB14C-D182-4179-A5A9-327FADCD7D41@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Date: Fri, 21 Feb 2025 11:55:03 -0700
In-Reply-To: <20250221163443.GA2128534@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Dave Chinner <david@fromorbit.com>,
 Eric Biggers <ebiggers@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 ronnie sahlberg <ronniesahlberg@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Steve French <sfrench@samba.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
References: <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali> <Z7UQHL5odYOBqAvo@dread.disaster.area>
 <20250218230643.fuc546ntkq3nnnom@pali>
 <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
 <20250221163443.GA2128534@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 21, 2025, at 9:34 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> We can define some new interface for return what xflags are supported
> by a particular file system.  This could either be the long-debated,
> but never implemented statfsx() system call.  Or it could be extending
> what gets returned by FS_IOC_GETXATTR by using one of the fs_pad
> fields in struct fsxattr.  This is arguably the simplest way of
> dealing with the problem.
> 
> I suppose the field could double as the bitmask field when
> FS_IOC_SETXATTR is called, but that just seems to be an overly complex
> set of semantics.  If someone really wants to do that, I wouldn't
> really complain, but then what we would actually call the field
> "flags_supported_on_get_bitmask_on_set" would seem a bit wordy.  :-)

The nice thing about allowing the bitmask on SET to mean "only set/clear
the specified fields" is that this allows a race-free mechanism to change
the flags, whereas GET+SET could be racy between two callers.

I don't think the two uses are incompatible.  If called as GET+SET, where
the GET will return the flags+mask, then any flag bits set/cleared should
also be in mask when SET, and all of the other bits are reset to the same
value.  If called as "SET flags+mask" with a limited number of bits, only
those bits in mask would be set/cleared, and the other bits would be left
as-is.

Cheers, Andreas






--Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme4zAgACgkQcqXauRfM
H+CdJg//dBRx+db5qUwq2Yw3g7IQY3oad5rMJH7yBoZbJP5hKD/Wltc0MPDd/27T
V/er82Zr/fFpsIrgLTDFe12sDxY5GtPJcAWFgq1+a03pVpaVCY8cCXbmRy/fqh+O
6FFDbgT8IDlNOm347SCV0GNkUa78orDoAGRrt2XcEIoD372hwaaXtPrcug2Nd++O
hiNl3rm3ZNQ81xEYTAYjLy4YZCkdITcar9XwZMxB6lapSTKA/TW43L8MTNivXdKs
Sq3aSXWQiD1L632Eryn5TjEiBIs9tms5/s22UPL955kClEchZCe914Uo3Z2l/1Wn
ksWn1Af/FDezp+sqKIFmkhPBYLFiqgkABKRq0WctsrfgfJOnnUzFO6gk6cxUnVo0
EhNg+1bjNppus7opDnhqRH8Jas+SBvdiIFvEhTGi9kvK4AhW4jmbarpywg43PQ3O
4f9v7UoKs3xV4uc4GQOu+EndOKphLMrz1tyh+rvmix4YqB95rXmdCFfUM+0BvtU6
SEEuUIDCytbASKgOaCeia9Ln9q6uF6lBoIMVIgfPVgxS6B3kFMfmSHgy91FBHL2j
Ma0IZkoOuOdnXSjZEMsoWT62HEBTuS5r7bfnlCaVfUk3ns2C2QjLdsg3ST0JcTUK
8ttgMxUzbin/ndOP1sy6Og4tz0ezJ/WgNsZsG+mKXZBbiml+unE=
=7F0J
-----END PGP SIGNATURE-----

--Apple-Mail=_345505F9-8A2C-4EAD-B7F6-99D3EECB5259--

