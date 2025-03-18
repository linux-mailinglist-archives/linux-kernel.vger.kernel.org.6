Return-Path: <linux-kernel+bounces-565915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A2A67106
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB38A3BAEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9946207DF1;
	Tue, 18 Mar 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N24W0y4B"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D91E51F9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293074; cv=none; b=snUrsIJFdfP/vMKz+qd9mM2Iob5Ucll0BtS9fg9eSlNMaZLAxy53/mmxjXJsdNuAeNc5XDmthXosUwoCYW2idwzRWG10gHPUAQd9yqyqlyu6lZd0omXy5RQ9XFbRLRleB6dOWQSRjFC+OYaSp0MKgQ858mWWfqZErzAFK5kX7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293074; c=relaxed/simple;
	bh=IFBxPeTjHI7TeObAp8XDFRUhMTnCq+H7JfaB8yzIjPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDijLBbdaTR7HqcbFVJSd6U6RqIza2yyeeUvq2NqrOqiP+y0o5F5GxvxB7KJDc+stGg6Hb1YAWtOqWmPyLpOBXDlPdZgr9Q1HBIyPQeaGKw/55yXoGacUKipVphAOu0Vp42CYZSu5nfEV9sIe5pNT9svjcVeChHpm+VUYVn/+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N24W0y4B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso28938355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742293067; x=1742897867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFBxPeTjHI7TeObAp8XDFRUhMTnCq+H7JfaB8yzIjPY=;
        b=N24W0y4BUC65V80kMsbWm+saRH/9kqOigHaw0N7gKMLK4/Z8bHLxGcvvTFjcJqmlHR
         Cltzu5pAuTFtIwiRsmdoUwUagW7n/z7mzZZHdZAASYow/PwV5AXuSNW1hdSxynX+86FJ
         b4NTbSrYdTFVinW2q9U6btF3WDPAz40oWc4vDpQb5HBizFKPP/c4AWC2daD+i2AhhlN9
         nuM/YpU1F1jsnMUjrEkDT/HnV3Ol8cwbkk57W+pmX6Xbh7XXyx0gUOa/5O2R9BMAGegM
         yi3qGLGehthcW2agJjFhLhWgmH02BdQuvQqdjzqCaiZFWGtPP71CcAofAI5U+D7kBYfI
         hpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293067; x=1742897867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFBxPeTjHI7TeObAp8XDFRUhMTnCq+H7JfaB8yzIjPY=;
        b=k/UsKIfWpofHlhO0Lcp3Z1DOevnHuMrBJuNtfiSA0KUpSxxinuhHwL7JqDI3R3Ngwf
         7dfB3cg8t7YK/z4kwIAqLT2Dkk0ouQjmOxapwpQZlezgjCIXIk8Y6jxvwcNAAUtdgM8Y
         Yc1XGlDQM6yLS2P2cMKR/9atsNSOHE5/0uIWsj/1XA+ld3ZQuLtP1bSS71rPmk3CM+N9
         Dr53OuHotgXnZ5XuxPGBMOOxLChfXn8Gl3kY0QXEIVfT3cr2T0ZlU4Ave22fAQDsKeWm
         C+t55bNADxNXPuv7br2FwEL+EZ3k827prQ9shdyTyZNa9xC045w6XSEMNGZ8SyuNSOc1
         wXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXHhgi+5e0PGGMQYbV/JvS26g3lp0crZ/Urhu+M1P8NzueAxQ/y+e/U2PJ7rdIsYd7URHcugvpeqCj7yz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/AFM1WbszQL+YyBaMzDzBtIQ7uU49ue/k2GYfQGXMUSLaF7r
	1RyJBBbMBTXS/3FHPOQnaZ8gHvEwFAZ0XKo5ANbKc/yR33g4pkgcm4TRypOwxf6VY+9A892G3xE
	QlbQ=
X-Gm-Gg: ASbGncv87ej1CceY7bpyFREbgAn5xaLMnlNR+Q2kQxeZK2a5zecNvss82dQL6WFarAV
	QVUBWhnbTy6iW3KAF2gtRBfPHjgZ96wQiKl9qHd1Rz4VQXEcMh8fWuqEWlmgVbmS8Avg2nviw6B
	r/w236PZ1RbbHti3/vltsIpNRgbxupC1VzacLeqaFDx+cnM7//y+wh4fUNRO2lxBgX6DUEhKubt
	/VmujlmuxFmH/HxItSvXRcueyqgaQZeDf180fM2mrqdIYuTHLBzRWTdgAQVmNzLKc6suR8e6SPp
	3LaiyGN2HU3fl8nSL5hs3703IHFt1321EsVt877VwdqRi6o=
X-Google-Smtp-Source: AGHT+IGDLa5UPBGfrRVOOm3XvQnMemu2Schtcck+5EYcWBJ65baV+gaiWnBiXGOVUyqS4P0tACKxdg==
X-Received: by 2002:a05:600c:4e8b:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d3b9dc596mr11587965e9.20.1742293066628;
        Tue, 18 Mar 2025 03:17:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ae040f9sm13194615e9.0.2025.03.18.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:17:46 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:17:44 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6wfz6q3cfwefzqq"
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-2-jiahao.kernel@gmail.com>


--m6wfz6q3cfwefzqq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

Hello.

On Tue, Mar 18, 2025 at 03:58:32PM +0800, Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> From: Hao Jia <jiahao1@lixiang.com>
>=20
> In proactive memory reclaim scenarios, it is necessary to
> accurately track proactive reclaim statistics to dynamically
> adjust the frequency and amount of memory being reclaimed
> proactively. Currently, proactive reclaim is included in
> direct reclaim statistics, which can make these
> direct reclaim statistics misleading.

How silly is it to have multiple memory.reclaim writers?
Would it make sense to bind those statistics to each such a write(r)
instead of the aggregated totals?

Michal

--m6wfz6q3cfwefzqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9lIRgAKCRAt3Wney77B
SRN9AQCIE/qNRp6gU2k+xnK3FHJnFxAelfP/oIqk3z71MjMSZgD/cizNdVftiC2U
CSpV9isE71qsCu5oCAFzbKznXsbF4Q8=
=Bloy
-----END PGP SIGNATURE-----

--m6wfz6q3cfwefzqq--

