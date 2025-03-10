Return-Path: <linux-kernel+bounces-553694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445BCA58DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C7A164C49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D0223311;
	Mon, 10 Mar 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="BqgMezPu"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CD222584
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593933; cv=none; b=sXafWQi2+xHfIPTSeuNphg6HScjG++FzbtPCucrssmrjfoYsbNlORXVC5/cEFbg/RPVCq6oEr43OZIZqCabtnzhPmc59yECj5ljThuM+Ka1KXBphE9q1bLINz8G91r7/US4h8qSYXvQ8UkhDLqXZjFFGspIHlY5LO8i9Glbg/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593933; c=relaxed/simple;
	bh=3zWnGu58N16ImW59wQBusJJKObQVZ1jczDB54CFg87Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7j9vZderH6idO0UE110hGvA3eJyXyTYkmcDQ3TVgMQeN9TPXWNbOg5KaHSCjdtsI7lfNEMIcDati8sdzn/xKAHg40WrADl/B07gybLXxKXBZ65UfOqognFdjzxJg+dQz3GpkQH1bYnsAqAzdAUGEPSeQCsmzfnAPQHK0LeX070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=BqgMezPu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso1968516a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1741593930; x=1742198730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/46n50lkXxXG2Ap+gYI/XvZtdQWDWRE7Pv0p9E/S7A=;
        b=BqgMezPu4DBwnxdrN72L/a2FDiNJoqB1r3qrmz0ArTnSWkeHKi/zZrfIl7uIWDGlnb
         s7+vV/+27ws9cLAEAuVr0o6QGsPc/mfPMAtppU17yce2gvUNJ0jlLBo6omHzqgEZGCZq
         R880fOHEfPGu7lXq8IfcahiV7lDbtI/KHVP9HXgGxtw2JNkKVkc08SCxNxVjxhM6CHgZ
         S9Q0ToTH+hSYICYeLWs8nQQkyNMrcmAdXMh3PkBxQ9T+VrS2b4vz1a/SiEsEYdkuw5HY
         gmfpr09IWvthDFL4Vl9M3QJOiyW6rSPS3GGwYMgkk3dS81GwrCsW08A/jajdCKoWc8Xr
         M0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593930; x=1742198730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/46n50lkXxXG2Ap+gYI/XvZtdQWDWRE7Pv0p9E/S7A=;
        b=vBkumXnuJ2gJcxJOu9tQIHou5N82mMtMajFwhGE+qxe70roNAdSSjBW2926yQbRM3L
         FNlNH9nUmdwOshxtENnvA86p5vB1QN1whZYlkeQFXVSiU0fi44LmsgbqjALXjH+XGVOv
         uPFrfzbe3Jf4Aq5hikWqtIFQZ9o2/oJOK/HfvceEAOc9vOYLblj0xzQF63BTrH1+bCED
         n2BwmSAo9nKoDYgWu7GJk4AZtAuquY9yhfjSsC2Q9w9ekdhHaVAh8Q2TnmjnwCqkjzeN
         vbJVLtcWLzvG2UUCCLQGJcBKZEvbqQLe6yT0XviFeUMCDgUkXVvjlY1uLImd4X/iRGRy
         HH9g==
X-Forwarded-Encrypted: i=1; AJvYcCU86c25VJxomuhSIA4pieHP2Fzt3fv4SHncwWtC0i198tncoGqMi36KzYW04hQUElMw/6cD3dXtZrtITJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnLsBW/H4sgq4FJdQuXpDofSrTCmI2kE5sAm59xrnYJ1DUq3Q
	5GtW2XrOT0zyUgUksRNbjyV2g+klXBeBCcBK90o7hQfD2x5IRjtDk1QtRMrdsPI=
X-Gm-Gg: ASbGncvoPYTOgVEoMoqV2eoJ7e7QQse2flgno1/E3ib2F2nV/52EDuHphQ14tDyg6DL
	pFXdpv9LluGR90EEcV5vQ78QBgZ9hoAU1i36GIdapRXOU3EQ9RvC5Z5pCuq4n4YaoZRrXVu36O7
	czEbTbWOaeXlPgcXhpAVDXizsK0gS25a9mO0EsN3te3K5PGLMQasUPvVjAQHFQ+cnYUG8A+K0tt
	q3idYH987W9XSB/UD8nmVXkkq1GnvIQOoqhSN9gsKEiuq+U+ld57pGlVvjZsgjiyb/tvoQ6HltO
	BB4xMudWHLhEGFizqbdqC9AKvkbZiCViikDfOBdvkpikabkM
X-Google-Smtp-Source: AGHT+IFyE1+ZQDfcpYaXDj6cU2hjRv5YTsTRSeNjT+LusaidpLpAMwAvHbC7htyCKPAPDOKqhc1SBg==
X-Received: by 2002:a05:6402:35d1:b0:5e6:6407:3b27 with SMTP id 4fb4d7f45d1cf-5e664073f4amr5039593a12.31.1741593929576;
        Mon, 10 Mar 2025 01:05:29 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fa47sm6471074a12.6.2025.03.10.01.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:05:28 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:09:36 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Convert comma to semicolon
Message-ID: <Z86eQH1dV0zEm3Ov@mail.gmail.com>
References: <20250310032045.651068-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310032045.651068-1-nichen@iscas.ac.cn>

On 25/03/10 11:20AM, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.

This is a typo, of course. Thanks!

> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Acked-by: Anton Protopopov <aspsk@isovalent.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/fd_array.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> index a1d52e73fb16..9add890c2d37 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fd_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> @@ -83,8 +83,8 @@ static inline int bpf_prog_get_map_ids(int prog_fd, __u32 *nr_map_ids, __u32 *ma
>  	int err;
>  
>  	memset(&info, 0, len);
> -	info.nr_map_ids = *nr_map_ids,
> -	info.map_ids = ptr_to_u64(map_ids),
> +	info.nr_map_ids = *nr_map_ids;
> +	info.map_ids = ptr_to_u64(map_ids);
>  
>  	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> -- 
> 2.25.1
> 

