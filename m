Return-Path: <linux-kernel+bounces-283478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23B94F570
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD2B1C21020
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3576C187842;
	Mon, 12 Aug 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EXPsSksu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB41189511
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481838; cv=none; b=j7fqQJVl7i8kL7MJhviM8qWMrqPFgqDIswXgeGs/hnGpVbmjl8h23+SH0BAKiFqtNKFOGHRF9/Kkz6iehOeRfERnxUbgBrGfPUc+FvSH4ir6WTBzqXsE0+9nKYLMIbvVmri6ZF8usjjQ6x59SdL/uG9FREOS3g3baD8bTHI39GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481838; c=relaxed/simple;
	bh=MSWheAYOm5uORv3/WCtLXbFVBaYVV4paR3isdB7aaWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlr/ZO2VmetA+7Ok37rPDeFBOVidcERTSYkyyJdcNffVhilv1ubaI+ibKm7ZoHH+fWvZblp2s7tu4jMv6l+/PQEulrl2pb9Dv9iXMimYtiSpFklF7pOwfBz/yzQuKiUcridqLhd3B3uTXO3n3yCI3Q04agqtWv+1Gkf1XGgEw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EXPsSksu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so558321366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723481835; x=1724086635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSWheAYOm5uORv3/WCtLXbFVBaYVV4paR3isdB7aaWA=;
        b=EXPsSksulhbu14+eyHeEEuTIuu3w4K7i756tPidsMd3NbXQcyAYLlAyyYtPsz+WY7Y
         OhMuw5t/G1FI2KjPtdjNrczewmFQHP8ZxpIOX6/wb2eBbX48dXmaU4vxEfUQshtnBBpw
         /GCDGm/QOWfGczOJM52ws0vAbfen8YyaZ7X+F1/p8CizS9pBIRrA4m+KR1fsxGu4pmp2
         5bmxOPacewTFQvqCaYlBSg14tSvmvkhgasKktyjUCeLTyy7rqQFimFs1iGPtEwuYv44t
         StBA3ZyhNLqWQY7z1Bve48G/TQM8prkqq20pbDOiROVEap40y1m/wodYjd0x4VD8AHTT
         JnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481835; x=1724086635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSWheAYOm5uORv3/WCtLXbFVBaYVV4paR3isdB7aaWA=;
        b=tEQ3W01+eKdyudLTvQZoQXfmoH8ZaeO9HpXZcVWRWxFFRh561p/fa5KP8ez8QaJL9F
         SEPmR0vlLah/wWcl2RNLFEdcPCluKa0MRoWCvtbeS4m+5HmHF3cuGR5kLDgWULcN17KK
         LvEQoLXWFCsxxKOhIJ5al2OHD58lIxcK0aNGwEjuiVvi93I1lGtQGNMWdlC3nM7pjoBO
         QHSsYu1a3vX4lfG//Pz7LN6WhlJs1tB9dZbf+ID27mxO5KFMnpPEAiWS3hDsBDG40mx5
         gGfcnHAY/gkRpf42tnIVsoICrrYYTaGeZupPrJVxQkQID0xZYhl+2ejZKZYDACg9fgT8
         oVfw==
X-Forwarded-Encrypted: i=1; AJvYcCXaDTkNbRKLXtJYFkb7U+y8QtCmfdJLLgR5zAS/8GWF5GffowQ0vpUbyL4/OLGdczoqwBEZd1NPWnwTYLJlZpX/cAiqr2B330oL42hB
X-Gm-Message-State: AOJu0YxO1vc+d0sfvbbA4fiSmrushM8tYhzubUGMHqXoyc1ZXB1v3F7/
	+oKFHcAhHcpMWPsYmzGZdizDqK8+81iPbVjVa/kGD5a8rwxUWHx58tZ/2mktFoo=
X-Google-Smtp-Source: AGHT+IG8DI/8ApiuNEjifMrK4rBjseINuAZz4OESjCkxUQKd+mruXpNXcSB3i9JLyRHHNcr+bNoYiQ==
X-Received: by 2002:a17:907:d841:b0:a7a:acae:3420 with SMTP id a640c23a62f3a-a80ed2c4d3emr67882666b.49.1723481834870;
        Mon, 12 Aug 2024 09:57:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08f6b8sm243602566b.20.2024.08.12.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:57:14 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:57:12 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] cgroup: update comment about delegation
Message-ID: <qk63o7tqgwt246tmjhvpnzd5ojuuhbndn44tdc54newzws3i5x@igea5nmzcoz5>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="is5odoxrqipkobog"
Content-Disposition: inline
In-Reply-To: <20240812073746.3070616-2-chenridong@huawei.com>


--is5odoxrqipkobog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2024 at 07:37:45AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> There are three interfaces that delegatee was not allowed to write.

Actually, the right way is to query
/sys/kernel/cgroup/delegate

> However, cgroup.threads was missed at some place, just add it.

When you're at it, could you change the docs to refer to the generic
definition of set set of delegatable files where it makes sense.

Thanks,
Michal

--is5odoxrqipkobog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZro+5gAKCRAt3Wney77B
SbJ9AP9qJuDZGebJ0/ukBJ5kkcdviUeldQJlj4sv6mz0BpetkgEA4p2fTqTxn3I4
h4lm0fR7jVm1mHsw1OmVLtv0TPHczg4=
=IYjR
-----END PGP SIGNATURE-----

--is5odoxrqipkobog--

