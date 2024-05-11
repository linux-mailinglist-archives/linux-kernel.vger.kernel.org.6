Return-Path: <linux-kernel+bounces-176495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7AD8C30C1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7462D1F22FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D25466C;
	Sat, 11 May 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjsuPRAs"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACD3BB21
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715425281; cv=none; b=pQwQq23rjnzsJ4gXgjN3jdagg95tfdgXdeR8qM7KnZPCaDaxDqJr4V9avs/K5OwINC0Sl9pcUskBuDs80W3KxPEuwieAjttSPhtMyRymsqDSnOL0AW7CAuSVUkuLj3/IGbAkRBDBfzj/yIP8kvtHdSrXcnROGQl0aPfYcNNgC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715425281; c=relaxed/simple;
	bh=uqpzDs5PJu+KR89NnlCjRDrSgT+5bjBJdVUiPLnPmn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZFlTJBKMpKb+cNOKl4qQqAccxV5BiWM8bEZTQ18d3IVMlYTZmCTGbvyF1F2E4EWN6vgIjcORSAARapu82RJHUWCQ1pIE/hnlBo8wrYHQ/hX53J6cwV6WY6TMs3STjKWcTkpTkb3SSDH2C7tku4UbNJIJrD6+2V6Do4tueWJ04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjsuPRAs; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so2458653a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715425280; x=1716030080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqpzDs5PJu+KR89NnlCjRDrSgT+5bjBJdVUiPLnPmn4=;
        b=gjsuPRAsX6V30L1urKxspC333Tomuyz3VIRVIEhHVYvC+TH3Xhi+WhwyaScs9x3H7A
         cWW9iNYvuTC/uwCWz7FSr7Opl+Y/JYmr1uqE6oHNz4jywWmRRh57osZ/3QbHYK0fEeJ4
         +ZUDpdxrJiFNlPUsjU7Qtg5xhdPvJAvCxk/g/m5Ca155psgX8YxnDDlhfb/FOZfDZicD
         WWRz2ZiPDPzWUsYSKh9zh6skZZXhKUQVsARjkyVXF0QN00L5wBt1Q/00NtKWHODQ2RdU
         xELzeOf2Mxsok+NvzDpl8B1m3/9qnuqnE1aOCG4FdVWkYeJlAhQUAaxYHJbiBLyVPT4W
         gtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715425280; x=1716030080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqpzDs5PJu+KR89NnlCjRDrSgT+5bjBJdVUiPLnPmn4=;
        b=qQF6N2R9HwB574x1p8ZJfGoOgDBQ4BaNxnKlGJMSbusu2QpVF46es0k6lJ6DsXbNff
         YkmCNDCMIKcfkX76cWQPx2whsR/uPssYn6DLpbiVhhH2XBQFWlrQVercGGTc3ijHD1Ab
         AbGV+7w9Q6Y6q2UOGFM+4klhc6us33qOpwsnItdEtDlx5oKQfS86wa8gQA+uF5lp3aTy
         QJK4laK78UerRiRJn5wNnctYcZvZVQzHlHU6EhXCgAS63m0y8uCNGjvl1h1BDqY66WI6
         Wl0ZSPJcLNOQfvkFKPoLEYnb+3vowPG9U5TDVZyEsMHYQe3NGvaMPonma6baHbx/5Z+D
         sGFw==
X-Forwarded-Encrypted: i=1; AJvYcCW16UiR+SnyotNw4CiFdA645dQCVOfm2CsNuOZzJ+sFzvd11HxY92UqM/urDVcVu8nQqPpbKEcBWm4kANyH5LtyNYs3Lve5ikl8MVTZ
X-Gm-Message-State: AOJu0YzYYpLeNcCeYLAA/AUPLIJPLjnTpdFyp/oUpOtWCW/pnYHAmEtU
	9ns42Ya69nWITRRI1g385/n7XKiNQaMXaW6rqrjlca7+TEQu5D8aBt2Wsg==
X-Google-Smtp-Source: AGHT+IHnP3NxL8IFhwpNioFQVTQYC75Bd7Or1Sx/5HITQvfIFy50lh81azGiult164ncXxlFSuQbsw==
X-Received: by 2002:a17:90b:4f46:b0:2b4:8eb6:895f with SMTP id 98e67ed59e1d1-2b6cc77458cmr4564049a91.16.1715425279524;
        Sat, 11 May 2024 04:01:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886d069sm6514667a91.25.2024.05.11.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:01:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C571A183B5E89; Sat, 11 May 2024 18:01:15 +0700 (WIB)
Date: Sat, 11 May 2024 18:01:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Paul Sherwood <paul.sherwood@codethink.co.uk>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] sched/deadline: Fix grammar and typos in comments
Message-ID: <Zj9P-9UBlZRTkmlm@archie.me>
References: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QB+qWVKr01ag/UVo"
Content-Disposition: inline
In-Reply-To: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>


--QB+qWVKr01ag/UVo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 09:26:44AM +0100, Paul Sherwood wrote:
> - conjugate verb to match subject of sentence
> - s/a entity/an entity/g
> - s/this misbehave/this misbehaviour/
> - a few typos
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
--=20
An old man doll... just what I always wanted! - Clara

--QB+qWVKr01ag/UVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZj9P9wAKCRD2uYlJVVFO
o+NyAQDye+I1gNzdgOi+HJZzbtGV1nTK+/8XMI36GnB3bS62xwD/T0nCL5kwsyy9
Lh+F5FFc8NTgFbpTh2RzaQtszYyt2wA=
=oigJ
-----END PGP SIGNATURE-----

--QB+qWVKr01ag/UVo--

