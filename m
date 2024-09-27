Return-Path: <linux-kernel+bounces-341934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F63988890
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE52C1C2084D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07213C914;
	Fri, 27 Sep 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H4nkdAAo"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808718B1A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452361; cv=none; b=Bqkdgv0A6JEiH3cFYoISL7LsFxW2QdMEJffV+pzR9VuFTJOg8kugSXtF4Sb0CBJjW+mxJplnuEQpe8fLMM2tffAEKyqWuqM7bvwIe6spPqjr9VtMjEO6A13AWzzhvuxKsxuWgGC3FPnXcPrsA3zY9QUUZU4q3gdtyL6BV/6UE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452361; c=relaxed/simple;
	bh=DCRTqeIGNLj6cpbf7pJD1veyOFDdaZUNMrsGE34kscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpqnGvJjonwDelD1hi0pv4h/LN5yel84bS73gK7BT9dQ2wmKUOhL6+GVTJg4tzOTtJtgajBBb/zA9MsBghRat73+f1+7h9hp9rt4LwPKjICE227GYxp25dZCSY3I7Y3JAS0xHYYrMv6s3+jWfghWaHwd/JErm/Qv9uhii8iOqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H4nkdAAo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so283492666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727452358; x=1728057158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCRTqeIGNLj6cpbf7pJD1veyOFDdaZUNMrsGE34kscU=;
        b=H4nkdAAoEMrYwhQ5K0y2bHfr/7kiqGTrIQp83JjUxh2YvXgWl1qohM47aDcPSFQFQh
         6Dfp3kT7ERF3bgrWOHu93NZzL8FQVB1at5flYozt/vMCadUGj/x1nPVG2nz/Y2tExgYb
         WpzyCtFqEIaF64YN4+qI6Q7e8eyH+NTAadWWyIYlN6jZvsy4QYXpUQSrGYxb+MED0iWP
         PausL/HxXO8/+vKGn1MzR8HnGB4J4pba7kYE1ZDffOWM9R8ZAA3PEYy1lpEQquVJ0Fdw
         iqm9HF0GL7Md0S//eTgzXUlcbFBG0/fpUA6iqJcBnxNUnTO8RcdyzBdYCMGuYK5RPaKF
         rQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452358; x=1728057158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCRTqeIGNLj6cpbf7pJD1veyOFDdaZUNMrsGE34kscU=;
        b=uRoKNd3GBEgGf7vvQXSswEEaN/NRlMNSEoDWUqQw/uxvCt2iuuX6ODm+CjM9Ykk+28
         m1WSmNaTHg0SrxXfXNvQNQUs5YMuGLhMTGxaOgW3KWQGnGA0cLEE+SYTSzKSHJDVWjcK
         NTeTGR9iwkkn9+UETex0YwcRuJGxCWDsrZQYzIqsCtpQAmrm76OrJycolXzhvy7wTuMe
         cqqwW7Y4xsZAmBpnQhUovTY9KVlYwdrnDjQo+QhGIlEAtFZf/7kDxoe/I22E/wjoffKG
         eUbap6YM9jbIGABVRCU23ZYNESQbv6LqlFJh1GXjroDqdKKXgymP7Bn99BQKq5yB11H3
         zDIw==
X-Forwarded-Encrypted: i=1; AJvYcCVyKExU+9c5Feh7p3rwLHAdfdaQQsD3+11jaIS1PhL7UYVjwiwdLvIEpVWdyOUPca9Qt2/VIle5ygurLyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIifFnMBP7kMueXE9ywZHpY6rucGTld7+4AYcPiZCDbPN5luO
	bQKxTl3UTL6xdHkSNK2zMZE/l+frc+F8G0h3AQtv2/GiBKwSdxnDopOvglUlR1U=
X-Google-Smtp-Source: AGHT+IEvGPXblsO0LHz8sVyMwKT714TDPpkSjLVXa7rJxqtJSZQCJc8zk5y+RKplxjkd5K7FpmpKnw==
X-Received: by 2002:a17:907:3f2a:b0:a86:6d39:cbfd with SMTP id a640c23a62f3a-a93c4aee57dmr371271166b.57.1727452357764;
        Fri, 27 Sep 2024 08:52:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a2absm147930366b.150.2024.09.27.08.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:52:37 -0700 (PDT)
Date: Fri, 27 Sep 2024 17:52:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Kaplan <David.Kaplan@amd.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Selective mitigation for trusted userspace
Message-ID: <ydu5mlvvvizkadyspu52afbdoyjq7akyx2665l3zit2tj6cs3s@4edufjodwmbu>
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sz5e4e22rjmp6q7e"
Content-Disposition: inline
In-Reply-To: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>


--sz5e4e22rjmp6q7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Sep 19, 2024 at 02:52:31PM GMT, Pawan Gupta <pawan.kumar.gupta@linu=
x.intel.com> wrote:
> This is an experimental series exploring the feasibility of selectively
> applying CPU vulnerability mitigations on a per-process basis. The
> motivation behind this work is to address the performance degradation
> experienced by trusted user-space applications due to system-wide CPU
> mitigations.

This is an interesting idea (like an extension of core scheduling).

> The rationale for choosing the cgroup interface over other potential
> interfaces, such as LSMs, is cgroup's inherent support for core schedulin=
g.

You don't list prctl (and process inheritance) interface here.

> Core scheduling allows the grouping of tasks such that they are scheduled
> to run on the same cores.=20

And that is actually the way how core scheduling is implemented AFAICS
-- cookie creation and passing via prctls.
Thus I don't find the implementation via a cgroup attribute ideal.

(I'd also say that cgroups are more organization/resource domains but
not so much security domains.)


> - Should child processes inherit the parent's unmitigated status?

Assuming turning off mitigations is a a privileged operation, the
fork could preserve it. It would be upon parent to clear it up properly
before handing over execution to a child (cf e.g. dropping uid=3D0).

HTH,
Michal

--sz5e4e22rjmp6q7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvbUwQAKCRAt3Wney77B
Sf78AP44kyb0iSRv/PmB/kuKgun/B7LdHm51eP9p/zFrLFqKfwEAuHuJ11zCeECP
TEqe4j35AlPUfTxUa9gbzH1OCr4/Gww=
=OdKa
-----END PGP SIGNATURE-----

--sz5e4e22rjmp6q7e--

