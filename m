Return-Path: <linux-kernel+bounces-285829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB760951344
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7241F234C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137441C73;
	Wed, 14 Aug 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iX2rBDey"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE591376E9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607831; cv=none; b=tdrz8LfRXrMOBxDfqNTgaOD0mwZQmr4E2NO1t3qQFItWMKGDeFUMdJ1kwoVZwcmwjjoLzfbFQtik3hpMFueYhimga6rWu6vcBPvledvrXro6wVObU/6Ytt4F/eN50aTcP0RiHzbSPhbX1vktBKyZSL7Om1BgNZUdV5pQKm7DlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607831; c=relaxed/simple;
	bh=7Xi8g+OW2Mwnv4G6RhDFaZ4yLtyTHVr077Uh1Qc9PD8=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type:
	 References; b=QJAmxStR05I/+i5G8XRTnho6qYDEQiguBg0969bkajKia1qhVM2ZboYPYEogbHKBewy0xmmGDxAbBK/1LyXtVamAPdz82AoJiQ18U/qRhHjUYA6N1hEsfjGYKeKMbe1lmFBPd17hwEedw3nmyyelB5MfLRkmE/AkyRTirP/NJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iX2rBDey; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240814035704epoutp04e43a3a27361410acfeb5d9454d61613d~rfC84-1YA2309923099epoutp04V
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:57:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240814035704epoutp04e43a3a27361410acfeb5d9454d61613d~rfC84-1YA2309923099epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723607824;
	bh=HTqK/5k9pVCbavgyjKOD0KpBgoWSb07DTHK36P6SGto=;
	h=From:Date:Subject:To:Cc:References:From;
	b=iX2rBDeyZBKWLGIhimtDEGCKy0FxO+s7/yI7iOkAMOtzrizmqfyo3Usx0RW6LlYzv
	 5RJdrc6Y5AhJBZDOpKLy+2joNMT5CHb0S1B2v51pLL0uZRIeExplbZ35VuN91Wy5e1
	 MsgRDCnWtUfh33BG5AA+uOn0zKXqRHs/UKG1HZg4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240814035703epcas1p384b73af4c67560e8c513c57960e7fb88~rfC7xhBX00359503595epcas1p3b;
	Wed, 14 Aug 2024 03:57:03 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.132]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WkDwG3dfdz4x9Pt; Wed, 14 Aug
	2024 03:57:02 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.8B.08992.E0B2CB66; Wed, 14 Aug 2024 12:57:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240814035701epcas1p21fdecb1ea56edb88951ea789a2123dd4~rfC6EsxUz0998609986epcas1p2s;
	Wed, 14 Aug 2024 03:57:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240814035701epsmtrp2ec69754bda65afa4b784046fccebafba~rfC6DmPx91686716867epsmtrp29;
	Wed, 14 Aug 2024 03:57:01 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-ac-66bc2b0e7180
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.2E.08964.D0B2CB66; Wed, 14 Aug 2024 12:57:01 +0900 (KST)
Received: from [127.0.1.1] (unknown [10.113.111.204]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240814035701epsmtip14f65cacc864072a6566c66c0400c650e~rfC5vWges3044930449epsmtip1k;
	Wed, 14 Aug 2024 03:57:01 +0000 (GMT)
From: Kwanghoon Son <k.son@samsung.com>
Date: Wed, 14 Aug 2024 12:57:01 +0900
Subject: [PATCH] drm/exynos: Remove unnecessary code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-remove_define-v1-1-7947ae6f747d@samsung.com>
X-B4-Tracking: v=1; b=H4sIAAwrvGYC/x2MQQqAIBQFrxJ/naCRFF0lIkxf9RdpKEgQ3j1pO
	QMzLyVERqKpeSkic+LgK6i2IXsaf0Cwq0yd7Ho5ql5EXCFjddjZQ+hRykFvFsaAanPH6p//Ny+
	lfFX6MClfAAAA
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,  Kwanghoon
	Son <k.son@samsung.com>
X-Mailer: b4 0.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmri6f9p40g2utUhYnri9isngwbxub
	xf9tE5ktrnx9z2Yx6f4EFoveNVeZLM6f38BucbbpDbvFpsfXWC0u75rDZjHj/D4mixmTX7I5
	8Hjs/baAxWPnrLvsHptWdbJ53O8+zuSxeUm9R9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk
	5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2qpFCWmFMKFApILC5W0rezKcov
	LUlVyMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjOuNm2krlgCUfF/8/cDYwz
	2LsYOTkkBEwkWtbvYexi5OIQEtjBKNHfeJ4dwvnEKNHed4QVpEpI4BujxM/HmjAd77+ug+rY
	yyix6FsvVMcrRolLf5+CdbAJqEssaVsLtoNFQFWi9fxhti5GDg5hoO6TXSwgYV4BQYmTM5+A
	2cwC8hLb385hhog7Sdzob2IDmSkhsIJR4v3SV2DbRAT6mCTmH3vNAuIwC2xilDh3cR0LxE3C
	Ep93r4FqWcghsfTmAmaIhIvEupn32WGKXh3fAmVLSXx+t5cNws6WOPoRxi6RuD5rESuEbSyx
	f+lkJpCzmQU0Jdbv0oc4lU/i3dceVpCwhACvREebEIQpL3GrsxyiUVTizNOPUAM9JBY/3cAM
	CcVYifunXjFOYJSfheT/WUj+n4WwawEj8ypGsdSC4tz01GTDAkN4pCbn525iBKdVLeMdjJfn
	/9M7xMjEwXiIUYKDWUmEN9BkV5oQb0piZVVqUX58UWlOavEhRlNgJExklhJNzgcm9rySeEMT
	SwMTMyNjEwtDM0Mlcd4zV8pShQTSE0tSs1NTC1KLYPqYODilGphU7lqEX3mYa3/j3evqcK+D
	KS+dbiiq1G+Z0eH05L5+ZxVvn2J/cqjPvquWj17NWNGRa+CnY6B7+EP0U71DeqlHFPwfSr6t
	ELfJZpOQ8Hy4lPen8RYXBYeJuzo/l21tfrp1XQpjb9cCQfZNFrdMHt0odXBrmHpp3r9QDwWB
	ibyqMcFnZe+WLkx9u86oN2nrbZbzy6/nn6pz/Pj/mZD9ttdbVZW2tB3fOvFR7Qn7p4ed/+lt
	ZedqDNda77lEJa803iZO919/p5ZOcEv+9US+pcw7W86cd/5mEW4zi8P7QcWOLz5O86b8z75d
	pLSzTK6xnZvbvOVh5/NT2nevmsw2irzrfKiP72u5/IfErfotH5RYijMSDbWYi4oTAVQw0ow0
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnC6v9p40gz3XpSxOXF/EZPFg3jY2
	i//bJjJbXPn6ns1i0v0JLBa9a64yWZw/v4Hd4mzTG3aLTY+vsVpc3jWHzWLG+X1MFjMmv2Rz
	4PHY+20Bi8fOWXfZPTat6mTzuN99nMlj85J6j74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4Mq4
	2baSuWAJR8X/z9wNjDPYuxg5OSQETCTef13H2MXIxSEksJtRYmVrOxtEQlSi43IjUIIDyBaW
	OHy4GKLmBaNE2+wHYDVsAuoSS9rWgg1iEVCVaD1/mA2kXhho6MkuFpAwr4CgxMmZT1hAwswC
	mhLrd+mDhJkF5CW2v53DDFHiJHGjv4kNZLyEwApGicXT/zOBOCICE5gk2mY+YwVxmAU2A2Vm
	b2eCOE5Y4vPuNWwTGAVmIVkyC2HJLCRLFjAyr2KUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vO
	z93ECI4XLc0djNtXfdA7xMjEwXiIUYKDWUmEN9BkV5oQb0piZVVqUX58UWlOavEhRmkOFiVx
	XvEXvSlCAumJJanZqakFqUUwWSYOTqkGJmklPq/opd/39VoILbh2U+vcnWabKt6Vv8/35jVd
	vlbEWpxWu8DBeuOFt9dlgx+0FVyedu+q3hRbnq8JVk9Vl6ay1iw7uOgPy3bJ2i2ZyZfPs6zT
	FtqRxuHIoF/5X+pYaFd2dpl8YYNYgPjq0/7nvlmeOXW98pkSb5nYxgDOcMb/+mGCi//vWPo+
	IsaP+eTCHsapqb7ujg/Nb51dwpQ0Y40nt0fviRmm85lZtr3pWzn9XXOlwfNHjUsVw5nTJqlE
	hn8MPbPVfdKGI/s4HUT3XPcqVZt/ImO1qbzNdIkJl102mB2S5845EzbZ5JD7DB3Fi/J33fs8
	Vv1qNtssvXCh3c7Wi9tflliwaHowvUqcpMRSnJFoqMVcVJwIAP6EEVAGAwAA
X-CMS-MailID: 20240814035701epcas1p21fdecb1ea56edb88951ea789a2123dd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240814035701epcas1p21fdecb1ea56edb88951ea789a2123dd4
References: <CGME20240814035701epcas1p21fdecb1ea56edb88951ea789a2123dd4@epcas1p2.samsung.com>

Function usage exynos_atomic_commit was removed in
commit 41cbf0fdaa28 ("drm/exynos: use atomic helper commit").
Remove unnecessary function declare.

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 81d501efd013..23646e55f142 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -254,10 +254,6 @@ static inline int exynos_drm_check_fimc_device(struct device *dev)
 }
 #endif
 
-int exynos_atomic_commit(struct drm_device *dev, struct drm_atomic_state *state,
-			 bool nonblock);
-
-
 extern struct platform_driver fimd_driver;
 extern struct platform_driver exynos5433_decon_driver;
 extern struct platform_driver decon_driver;

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240814-remove_define-580075bceaae

Best regards,
-- 
Kwanghoon Son <k.son@samsung.com>


