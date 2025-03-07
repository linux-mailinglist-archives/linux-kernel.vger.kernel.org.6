Return-Path: <linux-kernel+bounces-551511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A40A56D71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E01A3A3CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D823A9B0;
	Fri,  7 Mar 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOYd/pGB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03625238D22
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364399; cv=none; b=Bmyx2svBZSAA35+m2/1JDGNTeECt+E/PDDxdRzI6D2Bk5q0hgRrhQwe1dAhh+y+UP6D/FnhxQyi0s9crv1PGI2QHI4BpnQ1zkh/nRkJMhH46LHWKrI/Mrovo2S+P2RhJTJBcvxxmteaMz5y9AsrSqJa3s2MBKAVhszXSZ66/s/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364399; c=relaxed/simple;
	bh=MibkxaecrsdtN0IlgcvwNtbfOgJZf42RCy7CVAjeczw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsA7ufiOc8tfiSgF7NWvtwWU/tJkRzFNIYu5zT/0J8nk0juTIaAQW18jp/LzBfXvSEW3c+DqKbqoumgbSxVZjpmnX+gT7mdU2P7BwBXQDzSyV4AJHdD4b1O80mwwn31OrGLKicK4LMb9J4aLZR8L6/9MXZe8fU025NfbA6GZcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOYd/pGB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso2796192a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364395; x=1741969195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jm6irixwFb9W5g3Hk5DtrqlJdVqED6lv/LIf0U8JUZY=;
        b=kOYd/pGB8vBzcyLBg2soxzse8FgmNRmXTQeaRdseyZH6NmPmxJTzn+POE2NU/ZqT9V
         fXvfSsDp/UnWnFgpint2sPmQTrbFTHUtHJXxmVMA7XvSJIfNHMU/Ot7UbZP40dOF1Nnw
         vT/SocbCcWY6znrwGcjSjv9dK4CFdDKjWQGNFeOSn12/aNE97GH/irRIakUn+lyajrv5
         b89A0/sBYNxC0EjII2ttuWxfQEN0SE1eyJwFvSbE9A87l27x2rdw83jamjZswP0yfyDj
         m6054gbQMEpKXNF0niHcBCLH/xXke4e2cUwbx4oopvfoYTuBnp447r8aG/L2G6WKfrK4
         SHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364395; x=1741969195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm6irixwFb9W5g3Hk5DtrqlJdVqED6lv/LIf0U8JUZY=;
        b=SQJVJhy6mlKtsA95zgPtiBLWhDkACRmtJSjPyei8/fetbverMwrZvdx35WzWf+bXkC
         URZKIhyN7Q8nFqd8I4r0pbG7F81bexVFE5e9699Qgd7YGcrB++ffrbmB+1uUByR63Zuy
         RrlHpSXOjiGeU5HT9s8ZgJOiBKcJxXtEuPujsmuKyRrxRbdNz8by6HU83NYLW0n7kJby
         8ZR4mSLnCTYZNuoHemn+d6+WpvnahwyNizzzUqpQ+Dvy7mVFXJqBlFjbreqDQCqh4Dhh
         CpFEWWyRHuoiZ0X0x9gPBM+hljcVXfoGHPSDuiDdl4EC23Flwf/KEk30c1ButtVV9c2P
         u04g==
X-Forwarded-Encrypted: i=1; AJvYcCUipckyPHQ4gAH28fG3+YP89h7yvlafP+fM2UoFmTkbo2T5LcNyAp21bBncYdjUbvQKezTRQyl66PWW7Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CYfrIEHVnMObMRhE4haA/jfuHbMndjBF3709jLbYGZ3DpAf/
	75kWvrtovAzaf/FORMMzBE/46SB5RBod0+Ta3ju7tCCEzyLBa+k=
X-Gm-Gg: ASbGncts0GLG2OcMhTrFUTYv755NSuo0oU0JiHxyuGdADEOJs1OazQgKypAX378ABuc
	iu2Dvt6BUlMEUg8ENC1w7epd5+ApOD6ZqQ7U3T6U6IC3rRT0p8tnWnbVufl+IgQZyZV/MlHb7rF
	Frg/KGOiZ6uqBMFG1b0UEOxCbevp18KxFN3Ys3Z9d2otKOkkPwWZgExo4bLFiZRCgaC1I9EmVkl
	YliIfJ3wVerFnvxjIgBT1cPLwblv6B++G9BD8THpLaifYaAa1pBkxXT0rtt0UtYFybl6VU6joC9
	DIG7AeQtXVq2QlMfGgYPmUyRSigrk/y9XxA=
X-Google-Smtp-Source: AGHT+IH3QB0rwN1h0x8Mnz9cxWShv/o3L2wam2DYDdSzeMpHR3ElfGtMQeEolbyniA2BNyVY4wH8uA==
X-Received: by 2002:a17:906:6a1b:b0:abf:4892:b6ea with SMTP id a640c23a62f3a-ac252b35b39mr391113066b.25.1741364394878;
        Fri, 07 Mar 2025 08:19:54 -0800 (PST)
Received: from p183 ([178.172.147.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394389a7sm293303566b.5.2025.03.07.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:19:54 -0800 (PST)
Date: Fri, 7 Mar 2025 19:19:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/asm: inline constant inputs in rdpkru(), wrpkru()
Message-ID: <360f4fcc-8141-449c-a5fc-cd91182e0899@p183>
References: <20250306210710.3403-1-adobriyan@gmail.com>
 <3e354397-1666-4d63-b863-ef9f9d31fa37@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e354397-1666-4d63-b863-ef9f9d31fa37@intel.com>

On Thu, Mar 06, 2025 at 01:35:01PM -0800, Dave Hansen wrote:
> On 3/6/25 13:07, Alexey Dobriyan wrote:
> >  static inline void wrpkru(u32 pkru)
> >  {
> > -	u32 ecx = 0, edx = 0;
> > -
> >  	/*
> >  	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
> >  	 * requires that ecx = edx = 0.
> >  	 */
> >  	asm volatile(".byte 0x0f,0x01,0xef\n\t"
> > -		     : : "a" (pkru), "c"(ecx), "d"(edx));
> > +		     : : "a" (pkru), "c" (0), "d" (0));
> >  }
> 
> Hey Alexey,
> 
> I appreciate the patch. But I do like how it's written currently. I
> honestly kinda wish it went even further and did:
> 
> 	u32 eax = pkru;

I _think_ you can write   "eax" (pkru) .

I don't like the comment either. It just reiterates the SDM.
Trailing \n\t too -- they don't do anything in one-liners.

The function is basically:

	// wrpkru
	asm volatile (
		".byte 0x0f,0x01,0xef"
		:
		: "a" (pkru), "d" (0) , "c" (0)
	);

