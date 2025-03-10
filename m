Return-Path: <linux-kernel+bounces-554775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E4A59CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDAF1883AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A65232376;
	Mon, 10 Mar 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dgA0oPCj"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B1231A2D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626876; cv=none; b=k0QO9gOYnOo6TfBRaYu+/p+uj4cqJrMYqsxzwdP9qH/+kQqjAe6pxmyUtohbnGWx8KhNxSSrBHxiHOIpxP4ncz91xlTb6ERnu7lwW0k+uPOohBx3SJISbzmEnmDHZMGhqC4XjIREgyZ+F3b0QSE8eJ1Vc46nyB90jBE0kkG7iSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626876; c=relaxed/simple;
	bh=dq1XvillSPGnZAnwO8Jk6HlomInoRUGnAxVEhvsL/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAP6CE7nOG5ZDdh9Fl06a1IAsHyTYrygnIxgthufPv/PSuvgz9k/3GRwey4zzL33MQFXKWENxy+kOHtjuNloEZt+LLBHqYWI+gKDKs5d0ga2Ici0DOka4He9gPLRJPvvKgVMAPH6PwtxEXBV/nwIWy5lmok/bxnly4hJAKe2w44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dgA0oPCj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39140bd6317so1358679f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626873; x=1742231673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heWFhlz+SWz1xH5kFIwmWzIb+nauW24lGHRaxh0Rld0=;
        b=dgA0oPCjX2IEdYB9UjJli/tufzml5YNIqR1FFkwh6Knn9+Q8gjFM2Yi1U+n7zAOSo7
         X2bbhm4lwiT9VeMPHtuzkVMq6EYb86MdoGN7udZvHtl9gIM4C58Uae3Te913L7mduFV3
         gcNQCeMU+J6ahrcpNZiFmh5cJKBmAkxwb7+XZPJ4Gs8jGGawN51ui2mOzoGdGOnKevnS
         DHPmjOBlN3OjeczFT8PSpQr0kULwuAJg6eg6PXA6D+eB1rC3t9tX3HGioiQTaMlaWCpw
         sfbQE/3RYXBH8hBpbquZyHidbqBQsibEuGt8JivRKHxUn4XtQ7DXp+liKQX8ZETGr8D0
         IUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626873; x=1742231673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heWFhlz+SWz1xH5kFIwmWzIb+nauW24lGHRaxh0Rld0=;
        b=HQKcsfJq6NRybgDSEFb3pzAHuM1UZRM5mDrUIZY1UvhSdN1nKXilr0EVmDFw2A9obQ
         YV61QbR4bWLQxXpYz0zmR03UxpGsHqTsChopksk4YK1HycrgxLMbORjhxP93uqL/k0n1
         bP6H8SQ7FAB4fiAF9UMW5YJWFRtG3fQGJJfvS+SVHzYywx7Cx2YDUGRGXrgAfcz45TUg
         XXZiHP0kgjUd6/fhJkjptDhX4nX57sle8cb05ruoAcNgjLfJ2fyIu1aYTDxKGnWCcCe4
         kT0kS9RnkXX+6YXOzoGk6NLbg40kHwIzG7wVfU9S9ooGxUjtWFBN5IAJ1fslE1VtHMtA
         e5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJAX07n2ioXiuXtDGo2zhr3qLlksaN0koMoB2wJ8eNp5LbkpXL9eVvy+2D9qoIdFLX+czZ9T54ZfhhCFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5B6yuNl8ZuDeFMzG4GlnlPtsrb805DHxcGIFyejMiYW/imDZ7
	+DfDuN8n50HiKU6e+XexZSIHEORp3tpEQatkqLeCkgDtATVxq07LXxjMJWdqfyzHdIu6S7hTZlO
	eG3A=
X-Gm-Gg: ASbGncuAxW/+XLsAnpjXUR4jecualRH1krdEAMSQjTVl20rUiNkUXTbfkB2dm+Eymxp
	jsKNSDjsmDgae0kGyPNQJNLi78H7+uM6RigN3iMGQ86nLEbfs8xQJ5xgQIUE2b6bKpw4r/A1lAr
	hKOJOG8QnW1LEija4gKC7Hm1bxYKyvSxOmYmxKOWtvDtHAReT6orCnrE17FGt+S3CdGHJD+yeUb
	iW6co/lrGGQhxd37BVeVStEO+5VkRJo9Y0k3BD2UxlqqMpVolBaMcdSsZ9IbSIDdH+q0xCHH1mG
	V2Fi2Rz8XBNjmZ793vR3zxawON6v7+cpl/NMQVS2Ngmb6fI=
X-Google-Smtp-Source: AGHT+IHIfA6s47W3ZhsLWndjNxIG07Q9wUrct0SV7ZxC4AQ588su9NeqgtnaMCydV2H48+KZCdjFSQ==
X-Received: by 2002:a05:6000:178d:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-39132d77a7emr8940633f8f.5.1741626872767;
        Mon, 10 Mar 2025 10:14:32 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfbab43sm15840796f8f.15.2025.03.10.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:14:32 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:14:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Message-ID: <2vvwedzioiopvjhah4jxlc6a5gq4uayyj2s5gtjs455yojkhnn@rkxanxmh3hmu>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
 <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
 <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axv77jbvbeq5oriz"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>


--axv77jbvbeq5oriz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 11:02:22AM +0000, "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com> wrote:
> Do you think it should be rephrased to make it clearer?

Aha, I understand now why it confused you (with the paragraph about
realtime tasks right above interface files).

I'd consider such a minimal correction:

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1076,7 +1076,7 @@ cpufreq governor about the minimum desired frequency which should always be
 provided by a CPU, as well as the maximum desired frequency, which should not
 be exceeded by a CPU.

-WARNING: cgroup2 doesn't yet support control of realtime processes. For
+WARNING: cgroup2 doesn't yet support (bandwidth) control of realtime processes. For
 a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group
 scheduling of realtime processes, the cpu controller can only be enabled
 when all RT processes are in the root cgroup.  This limitation does


Of course wordier rewrite is possible but I find the text as you
originally proposed unclear due to several uses of "only" that imply
restrictions that aren't in place in reality.

Thanks,
Michal

--axv77jbvbeq5oriz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ88d9AAKCRAt3Wney77B
SZInAP9Rd3zY18EcqWow8FjgpvFFozQcWGVRKThYkSVY8rgSLwD9GbCUzDgg1aDb
cFJMyU4xEzEHa2BFoC6eDq1KMLSZqAA=
=CF/q
-----END PGP SIGNATURE-----

--axv77jbvbeq5oriz--

