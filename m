Return-Path: <linux-kernel+bounces-375908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E219A9CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504E11F22F13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA87176242;
	Tue, 22 Oct 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEPCOMPl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B315140E38
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586326; cv=none; b=Fj+LntCqboK5+DXcRjOogNfVdcuBwJ/3ZiJIZFStezfB8cYoAf4ryXQInH73zqa6ZCMhO9kHWFoKo4jj2ffBLAbztlphMCEaWH48Zi+zIE7DskAo+VpZvhsxCzdsN/HI8oO58RPVH/av7SOK8I0+2ToDUFRG401gbyT9QDgOpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586326; c=relaxed/simple;
	bh=OCXXwPDjBusbhR6au45ZUYnylB504NYSSRvZEaxUgj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aFWkTnFx5Begqaw42iSYMXSvbsoVagSPu1NWVTXpqlCVSb4N+scbQKXfEB/QBSWHZxIIgeKga0P+oofDIIkUHFmLsx2HolhC4aA80JmnwGcl8KiERiUdEss5tzGoLG3ZjJuBSbECIy6YrvjvOF+kCTEjytqZ5T1uWitV+wB/TNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEPCOMPl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729586324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OCXXwPDjBusbhR6au45ZUYnylB504NYSSRvZEaxUgj4=;
	b=DEPCOMPlmCv4vNp/Zk1wHemcjD2K3S2uEcIL2DHqlefIOc8EbdVuiNHU/wslgp3PAwrtcW
	mbvan7Qz5mkv4hc6D9lfCWdGW63oscvoCi/WTQKUWc3nrBmVvq+zZy6g+i/pvmiSI3psjh
	iPMZrUVoLSz5hD9eYw11/pEyJf6oWcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-4Srd3YvTNW273sDAd6GFnA-1; Tue, 22 Oct 2024 04:38:42 -0400
X-MC-Unique: 4Srd3YvTNW273sDAd6GFnA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso44434835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586321; x=1730191121;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCXXwPDjBusbhR6au45ZUYnylB504NYSSRvZEaxUgj4=;
        b=GtamwB6ZULdGZoElKPryW93/hGV+QhzXO8Tc9EoENPUrBrO1vzLAhXhzvJg8wm2ydL
         bSPF2BjAotvoW2Dp5IT81LE3Dp6SWphCsP4BkKa7cst2YYfBgKUeyU+YFTEaYAC6v41K
         SKu2bMWnEPFZhf2ma5gnwDgtteY/HG2ZtZk9cMVgP3cELWXlACUn5UHzHlkVz9oDLiSt
         RI0zTUDvlcVj270pjRg+fSS+XSE/FrUmmvICT9njgtM++xukgUz8nV2gwt+GgtgEf1Ro
         7zpudWYPHRLBm0nNbHXcSajoLfH88jpfv+ljTsAYycMTBfvaIsct2n2+JyyFppLP0It2
         7IMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlK+XYhzckXdUDKCxGgj6hQpWK3CCHNeUryCRYMxHwloxacmUJJck9sc+NCr65LqWu5U6p6fhzrG2kmiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdYRMnhP+GLEtZPcqwdV/W+6YKxTVl1cl6kBlvxx/WPs7zYwN
	4bBcT99j3BxJTc4lsDIz/pj8MXff32nA+wEhmFfMrtsCqSrTzD5C0v4wj0T58z3ntDlPUYRH3ri
	xCTjlMFIfBi8qIpZSF4+9pUiE05yfk8kKJPvTmvczX2+bOYaS8KRfnxkiHiHong==
X-Received: by 2002:a05:600c:4e12:b0:431:4a5a:f08f with SMTP id 5b1f17b1804b1-4316161ee27mr124495605e9.4.1729586321177;
        Tue, 22 Oct 2024 01:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbBWOU2Nx4vFSYQiZrLPFEBJcR3dEePc/jhzMJIAF2UjsfwsYkjsK7i1T0LhglK0o3pCuU0w==
X-Received: by 2002:a05:600c:4e12:b0:431:4a5a:f08f with SMTP id 5b1f17b1804b1-4316161ee27mr124495345e9.4.1729586320618;
        Tue, 22 Oct 2024 01:38:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58f0efsm82150545e9.26.2024.10.22.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:38:40 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:38:39 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Subject: Requirements to merge new heaps in the kernel
Message-ID: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hsjf2vnvcet2h2ku"
Content-Disposition: inline


--hsjf2vnvcet2h2ku
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Requirements to merge new heaps in the kernel
MIME-Version: 1.0

Hi Sumit,

I wanted to follow-up on the discussion we had at Plumbers with John and
T.J. about (among other things) adding new heaps to the kernel.

I'm still interested in merging a carve-out driver[1], since it seems to be
in every vendor BSP and got asked again last week.

I remember from our discussion that for new heap types to be merged, we
needed a kernel use-case. Looking back, I'm not entirely sure how one
can provide that given that heaps are essentially facilities for
user-space.

Am I misremembering or missing something? What are the requirements for
you to consider adding a new heap driver?

Thanks!
Maxime

1: https://lore.kernel.org/dri-devel/20240515-dma-buf-ecc-heap-v1-1-54cbbd049511@kernel.org/

--hsjf2vnvcet2h2ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxdkjwAKCRAnX84Zoj2+
djCtAYC0rCU2tqFwwMRRkdC0+X4UkE+T1TaC7DwuQMpeIzJA4HKzDz2v6n9TItr0
LTH6SysBgI3OFvgyXDR/NxKo6lihPc9mfEb0LLL+suXmLUnK3QO9N/TS9HFxj7JH
hI9UPHPo0A==
=ZRbj
-----END PGP SIGNATURE-----

--hsjf2vnvcet2h2ku--


