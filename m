Return-Path: <linux-kernel+bounces-359692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD1998F21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9128C28A2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626219D083;
	Thu, 10 Oct 2024 17:59:32 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A81CBEA7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583172; cv=none; b=Z/rObURx51VKA1AdhX4tyqgn+rBJVovbALZFIfQvaV5m92iDot86KshxKG+L3DeOlN3jLsYH6txrLQt7FGX6UQJw5oVmKKQyrgG4QFkPIiE5tfpptEGpb3TtWWD1ODvspSt9twb0QucwbUC3AYleoS9EBdqBadhiuvwRy03emxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583172; c=relaxed/simple;
	bh=RlqVEm7hlQ7c1Xw9SH/CMR5gdNLZRgvV2Xm8S+4w9cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCUnmHTf535CXUJ9cTdx2KfVsi89tP/+Z6bJyXXukvXfxUM6T6RC9e8y+NEiWe2S5Q5XlHivLZYdKaRy3eQ7ASS2z1p+RTNLeijK33Qcgczip/5txYXNSXL4/Pn/SDG3mgfG2SLZZvgpjkuPkLq9imKQ7sWyvNBAAPm0BQT+lTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6dbb24ee2ebso14685457b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583170; x=1729187970;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlqVEm7hlQ7c1Xw9SH/CMR5gdNLZRgvV2Xm8S+4w9cc=;
        b=Wbd4i/UFNCJti+z3laOYXmUQURQXX/wqt+uxV5FS/JPJpJqRN9aeEw+qY9QFke+Gob
         Hlxa9nb3oDm18i7qhwhJ+/ksMwoxocyhFy/VxBbyls/VFWRMcqHd5axiG3Wr7FNGhZ18
         hd7+vFlXWP0Za+f8sLcbGSvTLxcvlUacp5hWI+ChD8kKCzH+AneHrhk41uW8ihTIN7R6
         32YO7V3d1ddHNOCQrd3d0j+hIeiGR19zz2oIvY51cYgapMgHshFA6qeTZR2mPgXqrvoZ
         rMHNH9uhDqEfzd/1EK7j+tfdQgwoNamZHxWo8h/eCsDa8FLV3sOC2KWnCiSPNufUXoGf
         nIqw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Pu+6l/89xyjTl0UYBEfrTFKhe6XdC+4jRFE5j1/bwXcih43yKNgCZf7EHHBsYhufrYzt8qDTeCrCWxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLoEe0grRnX1u5gSZKUhbs6MHksIgUF9Qu/eJO0FJaQmpgIaq
	pZSsMVOuQ5hqCJILbGqFikbKY4AE7cKU5RcCf8oV0Y+7Y8d/KuqKx3nwJw==
X-Google-Smtp-Source: AGHT+IE8sGUf8UIPdtWOz0Zt0mAyMT54y/HhHTp1i9gpw4d9tOPqGUWU+US7JZLp0K1XwYuWFtx6HQ==
X-Received: by 2002:a05:690c:3082:b0:6e3:4190:ab45 with SMTP id 00721157ae682-6e343cbc0e9mr2033797b3.15.1728583169281;
        Thu, 10 Oct 2024 10:59:29 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332bad8afsm2916797b3.59.2024.10.10.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:28 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:59:26 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 1/6] Revert "sched_ext: Use shorter slice while bypassing"
Message-ID: <20241010175926.GA28209@maniforge>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J8HuaA2LTHU5Ag/W"
Content-Disposition: inline
In-Reply-To: <20241009214411.681233-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--J8HuaA2LTHU5Ag/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:40:57AM -1000, Tejun Heo wrote:
> This reverts commit 6f34d8d382d64e7d8e77f5a9ddfd06f4c04937b0.
>=20
> Slice length is ignored while bypassing and tasks are switched on every t=
ick
> and thus the patch does not make any difference. The perceived difference
> was from test noise.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--J8HuaA2LTHU5Ag/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwgV/gAKCRBZ5LhpZcTz
ZKPVAQD2tmekeuF69Lm2YD51JbYkQLAX0dd/8Hrabsze2u5oogD8C7J1yvLLDBPV
Ea56LXAXwEU3re4kAaUSxW7sZuuewgw=
=w7LJ
-----END PGP SIGNATURE-----

--J8HuaA2LTHU5Ag/W--

