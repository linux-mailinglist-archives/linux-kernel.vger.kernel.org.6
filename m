Return-Path: <linux-kernel+bounces-329298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50B978FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503A91F21A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847411CEE8A;
	Sat, 14 Sep 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtft83Jm"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7A1CEAC3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307856; cv=none; b=TVIErGAOJzoDUHkiozKiS8WYYtcSBBL69IAdotMo2+FtvMXtYQ5vBM5cS2qc+NoSELDhJD0NuVCEOh7bzoKfGbm2hM8p74rwl4a+A6d8oXd0xqnfQG4rSY6lu8ulWKvV3jalqFIjIn8onatVvWyOOpdWlB/hioYbxL5niQwA0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307856; c=relaxed/simple;
	bh=vC+gKpfOvOeBPrlQ1T7rQky/AseG1kthoailPrpBbtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K4EKSVvXGfL9a9EEdkgNwHlz7k0L15rzooPR+VBqcSq8SWZR0JCATjWirryh20LVvmeeETsnyadUkKnr6vYDTEJiJ/6lfQwFYiN0CdfmPwyv+Gd0HVau7HCuEgkHiby3565B5ACPvvcbQge/tAz4WZ76i5VZ18aVUo1e5XiCIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtft83Jm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so2059042a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726307852; x=1726912652; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KE+o4GW15mD0lO9Q1MSUje0WFegNuMWBNx0d+tJV9y8=;
        b=xtft83Jmdn/3yyvJxRBOhB4jxpUZT/Po/ywj7FZlDNXUnUZgUkMntbiDOwyRTHNyET
         L82hYaMwSrzJnJFtm+0yJVaIMu/8Z68BPTAJKMARZIGnsm9loxfvU9jHBKBfiZsr8UWG
         bV78oxw0CHFA8LbxwMYPkaj25ruvGUhkWsMiEyaMmwqf4YUAQdm0sUUxtbxH/GOIiocx
         /a5CrqJCB0NX4trepv73UGKxJzdb6pgrqPRFwgC01Kh8m25r7sXPL3cbDkBi/CJYMM9p
         vrlnvUoTN4xVPWasqqiqLtjYlxEEpxOurUj3SVZII0F/JTeZaJXICXZRZOn7OWuuIds4
         HpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307852; x=1726912652;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KE+o4GW15mD0lO9Q1MSUje0WFegNuMWBNx0d+tJV9y8=;
        b=DGuvB6DmBrrXK70/SLkJiQIfeOcGCG0K4LU40YfHXRy3HO4ipPr6sv1CxwUCVDq02N
         bZ5zDAfi/vnaEy4k8cCbeYuoAl5JwfYmODjcNI4F8AbdYKPFW+7IYuMQxXbueUdH9dkk
         CwUPCRzS6N4PFPxD/nJ+81+cZ+vUzzhNq9Mq8LK9vJRBPcMcDwZWy48BE8dJaQV8NO1x
         QBh559o8w/tVf4L94j5ij2DcCaqhdbelqKdeSO+emPNEuqx84sEQ3J27bvlUGC9SF8ok
         8PlWdK3+eg2ESfzrDvWb/2dXrWMzQ6J2qiBphJkAUF022u2AzxbjQsVGEmmxwGJplCin
         DD2w==
X-Forwarded-Encrypted: i=1; AJvYcCXVvmTlB9qQfsRbl+mwpv9bUgcsN4gvKyQPyroDqZ8FMNWebNgmO002fQFiXdxuGqY0rm3KYsu+xPrA/Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbn9k7dSRw81ykpup/cd6GWtc4RAHP6RSaXBS0/3T/L0DinZg
	COkmJqJ1zEAsvqgk/8kya9OQtJ4t5kD6e0554CKePDMqUZ1IAvREKIOUALIn5k0=
X-Google-Smtp-Source: AGHT+IEQayo62aQvlqZj9eNFA3UtGiSNdY1Nd2T98Zj0wlkmKEFR6sdcxKopa5NxgGNy9WPY2H8KdQ==
X-Received: by 2002:a17:907:608d:b0:a86:79a2:ab15 with SMTP id a640c23a62f3a-a9048102110mr498501066b.40.1726307852548;
        Sat, 14 Sep 2024 02:57:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096779sm61360966b.25.2024.09.14.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:57:32 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:57:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ice: Fix a couple NULL vs IS_ERR() bugs
Message-ID: <7f7aeb91-8771-47b8-9275-9d9f64f947dd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ice_repr_create() function returns error pointers.  It never returns
NULL.  Fix the callers to check for IS_ERR().

Fixes: 977514fb0fa8 ("ice: create port representor for SF")
Fixes: 415db8399d06 ("ice: make representor code generic")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 00d4a9125dfa..970a99a52bf1 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -452,8 +452,8 @@ struct ice_repr *ice_repr_create_vf(struct ice_vf *vf)
 		return ERR_PTR(-EINVAL);
 
 	repr = ice_repr_create(vsi);
-	if (!repr)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(repr))
+		return repr;
 
 	repr->type = ICE_REPR_TYPE_VF;
 	repr->vf = vf;
@@ -501,8 +501,8 @@ struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf)
 {
 	struct ice_repr *repr = ice_repr_create(sf->vsi);
 
-	if (!repr)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(repr))
+		return repr;
 
 	repr->type = ICE_REPR_TYPE_SF;
 	repr->sf = sf;
-- 
2.45.2


