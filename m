Return-Path: <linux-kernel+bounces-394851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D89BB4DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1ABB2494E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38B1B3933;
	Mon,  4 Nov 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="GWWQCx9x"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BB1ABEDC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724177; cv=none; b=B5IB34fYyShl7sv5CsXatYMvLcPqCWSM5Od48OfSNhkqQ/1abEkqdYwk4tgnIcvYG3112t9c6BTK6vv39OMofa4WmA/4n5g8v3A61iVvhWVnlCYJQHib9LqyvFZxvIcn0cIoxnYq+qWrslmc7K1YXv+G2T+2X1Fga7mfsgEzKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724177; c=relaxed/simple;
	bh=IPvEnzYv1ZCXrN2PlDfCL0rkSO3hxGvJg6ElxwVmFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV921S+Imzx6N/gw133IxdHvddCTieXZMYUPpqD0jqE57sfSxGCwZUeiMxD4MegFQNQxRV5AJJbTsvGr2j9NQZ8X0S0GPHGlFUUTJodF1K3xBC0eTYS+npIoPngsoaHMzErUvyhlOCsVGH7L1MhHvVZEQiPrH4H6sAKp45mdF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=GWWQCx9x; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e3f35268so5131192e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724174; x=1731328974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPvEnzYv1ZCXrN2PlDfCL0rkSO3hxGvJg6ElxwVmFAg=;
        b=GWWQCx9x7VNVu9mVmfgTVzDD/BMqt0tSa2YdYsCErxfpl0Qw+HNetInL2jy2f906Jx
         1LemAUeExhvDlZ4EU7NpEanZNftEseqwFmjXvEEtgt0rrooiAJPctlwClhmFyE4ciQTl
         3F6f2F+qwBfb6RpV5QKF0uxQRhhSddA5Rralw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724174; x=1731328974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPvEnzYv1ZCXrN2PlDfCL0rkSO3hxGvJg6ElxwVmFAg=;
        b=YxZY+IAe3joQR/BOD8zyOIDLxKB8/9CRwcb3j16yYN3Y/qem+mpaUjOGPacGYZLmZY
         6vFCBsjYiryZVttHIaoZSXE9Nn+0W69wiAUuERUKg5K81M35QEyr0PJK+GDB2rzTRnL/
         XabiuSt6GXPTVjtZUJnhhQl+U9l8OiDF7JGU81yZaS2sf/Tq4SoHDW25t82rvGVlLB57
         tZzUP4Ns2btAq8eV2uvo7q7pcoGE10CGXcV/jcl9YM6A735iI22r59siaTu8MCpiyh8u
         Zo4uosrR3Xof4J4gvRzTM1i9ds/YYAT6iwkOP7c073fqRpLAivZtmx6qj6xm4p03Vsfv
         5HBg==
X-Forwarded-Encrypted: i=1; AJvYcCV0wTmV+CkkPIJ2r2VLYOZ22duXVuyfHVT53eT9N8nbcUVyctGfsXOmcS27BvMnoJ7xSi0NDrSVsxl2k4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFjrQz9RqvssEEyDyMwOzv4P2Ev5bjct6jYg/N7eK1an2ErUt
	FKSz/hRHbUJVTMGmZ3uRA6nvDqvVDjE6kBlCb/bps5N4fngeJBmYmRfh9vWj2HY=
X-Google-Smtp-Source: AGHT+IF9JIDhBxE4JO9TsU9zUsb+lHX1Ew/DDycr5M9Wq8vjS+4XfXIXAte9E7LEpHb0iSTZfAqgYg==
X-Received: by 2002:a05:6512:3d09:b0:536:9f02:17b4 with SMTP id 2adb3069b0e04-53d65e1abb3mr5805002e87.40.1730724174024;
        Mon, 04 Nov 2024 04:42:54 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:42:53 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org
Subject: [PATCH 0/3] EDAC/igen6: Avoid segmentation fault and add polling support
Date: Mon,  4 Nov 2024 12:40:51 +0000
Message-ID: <20241104124237.124109-1-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Qiuxu.

Thank you for your help and guidance. Here is the updated patch set to fix
segmentation fault and to add polling support.

Patch 1: Avoid segmentation fault during rmmod
Patch 2: Initialize edac_op_state according to the configuration data
Patch 3: Add polling support

Please let me know if you would like me to change or improve anything.


