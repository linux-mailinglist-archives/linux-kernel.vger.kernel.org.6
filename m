Return-Path: <linux-kernel+bounces-340470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452239873D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352B01C22EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3821B813;
	Thu, 26 Sep 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IbY4Xff/"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB84436E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354959; cv=none; b=H3nrNvPDp6OoiK/8+J35WcBmCv+q9hjyzxq/78N3JL381Z+kFISFZZ73s6rbn0rPrMHwdObTmj05GzBKzX8seaHmko079fMjApknC4SOhYCMW8ba2M1daiokJ3Bfe7sP5S2MuJhT06hNIvUhSYiM6HLNQyyoijR6jrTLj7hlVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354959; c=relaxed/simple;
	bh=0vFgW8iaVyfkEzvfu/sDFbw+qsP6jr/5nM6bnT35wsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQbP1tx1FfqvA6sykPpx4CYcQGRnm9sSTgpK0yf0u+BqtB561QuWAfcwk3Y/f9NHnjSQl+BTsp7RqxjmE60Eg7atq0Tr9i1EcL7mGRZEZ8v8HbC2v2WbaEps6XR7HsEjKy7Y511pkFgE5ISuMCOOp+A4S4XDIzUe91FFeMaWLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IbY4Xff/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a90188ae58eso118431966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727354956; x=1727959756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEzNs5X2U+4QjOcoEN5NdXTrAWb0DjjOJ5JvokADoHo=;
        b=IbY4Xff/BQJKa93eli/SR3WOT2HV6g4ZeFdzI5J6a1AV+fbwEM50AedmgZ1n9hC8cT
         4B4rtaG+EyLMoXht6AZumwDZxgdH4ISOGjvV+BbXxCawRMp09MqBxBfHuED/N8HWw4nD
         JrmF7yF5iYwpTaL/KAyy1uwU5uPbkE2vAi3+UAyMIzB0g9jQF9ycQBGqd2Ph/Uy808UU
         8dgmimVIGlKAXz1d0K13cxXQLGuWu1hxy9nUBj1lkERTBFRPTDthkaDsJNIm2Tf03LH4
         pGsM9TuYNgdGuI47X/67IPwOp/cQOyx5T2A/jGVf9DeRJKXhIETnG912JZ55bfu4c98n
         Lt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354956; x=1727959756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEzNs5X2U+4QjOcoEN5NdXTrAWb0DjjOJ5JvokADoHo=;
        b=oKDyC+IMhNkf9VQbswWxVlfn2u1lf7erTOPNG6ryyW0aW/jXs0KEVYxGrMuolxFPZX
         u8nEMKr1M4YPk75WXKcMkk+7wff43Y6KykC9zKeYr5fTsnSv2YxNDW/9ija+v3mAVkVd
         vL3dWHHYqdm+GLnU7SI1PVQNriShYE/aWE2IN3rMddP6OsqYb3nURwQnz2SiNcI3ACgx
         damk3sOBD6wVcqqrEZRlkI4NTQF34GItMTdVAxH87K4UylRCaQL8h7ibd01DNp2L1tes
         SqbCa0BpB3O3bf2EESA4KhL+60j9cyFH0vVOZfyASuOgjgEEoFOR2v3w/ortw4tgYiS3
         osuw==
X-Forwarded-Encrypted: i=1; AJvYcCVdSX828GNd+PCd88YT/CklRvzZXvK2T5cOCd/P9355s2yPFzVoci5NC51tfJ498MMG+kpwc7TDssP6zrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxYJobNX3Np5i3++xuXoddChrvW4s05O8z/cJcGsCzFXqMcQO
	uLwXMBKgJVcatl8jBuTnrtiT2/PS3Uqz4fSlgKxFJlmxUbI6M2cpjsFcNakFT3Y=
X-Google-Smtp-Source: AGHT+IHQL6L8P4lVbv+zBuFEYqMPsmJPuuAAnpGA8A07t/THwIG4m97Qhdhb4gKZs+R2fHDtX5g60w==
X-Received: by 2002:a17:906:dc90:b0:a90:b73f:61ce with SMTP id a640c23a62f3a-a93a00ffb79mr491568766b.0.1727354955847;
        Thu, 26 Sep 2024 05:49:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a5b82fbasm203728666b.103.2024.09.26.05.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:49:15 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:49:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cgroup/bpf: use a dedicated workqueue for cgroup
 bpf destruction
Message-ID: <24rp7n32rtzdszc7zxwmeitfmtib5yu7wo432b7uxjkvbdtrxp@kemt7l74yich>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ujd33ujj2wpmyg5"
Content-Disposition: inline
In-Reply-To: <20240923114352.4001560-2-chenridong@huaweicloud.com>


--7ujd33ujj2wpmyg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Sep 23, 2024 at 11:43:50AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> +static int __init cgroup_bpf_wq_init(void)
> +{
> +	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
> +	WARN_ON_ONCE(!cgroup_bpf_destroy_wq);
> +	return 0;
> +}
> +core_initcall(cgroup_bpf_wq_init);

I think hard fail (panic() if you want to avoid BUG_ON) would be
warranted here and mere warning would leave system exposed to worse
errors later (and _ONCE in an initcall looks unnecessary).

Maybe look at other global wqs. I see that returning -ENOMEM might be an
option, however, I don't see that initcall's return value would be
processed anywhere currently :-/

Besides this allocation failpath this is a sensible change to me.

Thanks,
Michal

--7ujd33ujj2wpmyg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvVYRwAKCRAt3Wney77B
Sc5ZAQDIAIHbAI5dt6odKSDav3lvJqhWvF548b3q6BwxebKNdAEA76WvMEO6J3xy
ihOXcWJdjwb1sxv9Yi42mX4HKCz1OwQ=
=8iZS
-----END PGP SIGNATURE-----

--7ujd33ujj2wpmyg5--

