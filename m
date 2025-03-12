Return-Path: <linux-kernel+bounces-557762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A6CA5DD56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074E916C7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955C242909;
	Wed, 12 Mar 2025 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LprurFF6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52320243956;
	Wed, 12 Mar 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784763; cv=none; b=TYZkir2Lrp0Be+4F5nD57ntdcD6i911Ckdzr+GLb8RAv1gWNjRI+mHmZqSYz6RAtPZpn/E3X9oIgbD+iU2I20rmrz5cQuFs9150rTFhNeSLZEpYUIo/yDjG9C37MTtplGBNu8BP+2PPNeqlrJUBTRnvOo/0+1f8aWelQYTunb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784763; c=relaxed/simple;
	bh=jyTw2zVZYzoVlQ5CY0DfcRAyGjPjDIDiRgaSyWc0K48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZazP/xWQBB8bg2oT3xSlRgqk+eINKpouP6NyngaWs++89WSlrx5qNQRK1FOLbpsu13/uIaWBQSFgXYSzTVvlSaAaefdwQhB71jvZtHvaP858dsaeS5tUKfvmrHOPfy5SZ1n64MedpCNvBE25sxfwQk1W7TVrE8SWFc6Y7xbjUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LprurFF6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso118256435ad.2;
        Wed, 12 Mar 2025 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784761; x=1742389561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyTw2zVZYzoVlQ5CY0DfcRAyGjPjDIDiRgaSyWc0K48=;
        b=LprurFF6+Vx3XCpi5YtTSwZHUIlXnrChm4lsIJMUQ3C4tJxNV2tC1ub3u4Uew7CjK8
         eYtoeARCIStNeVZRnhsyodsW6bnUWaZNkDvp7QHm7+Xfz0aggUGwPFCurokeV9cx5JG3
         acUxid/fGv3DQIGiMot5ykI8uEpHtF+Hhba6/emGSOefoUee1HLXpUBkDVt9W473E2mU
         qsDc5vqm4nRJKhpWlhYWsct0APTGG7h/Q6HbtNbDW7xXT+ClCNcxyJXnqQ4nvucr8i0p
         cMoMwXf3BqEehNRLH4UPE7JXg/amoZJjixlkNUPIQvXB3/HsAX5eDTiF6D0SE5HsBzo6
         ai6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784761; x=1742389561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyTw2zVZYzoVlQ5CY0DfcRAyGjPjDIDiRgaSyWc0K48=;
        b=MW8GeOiqwnSa6vqametaWxAhutspM9myuhr+CJ1AihnsYJ9hHBSXUC6EnxaWY/xgKK
         o8StKwz7ZgDw51wwmUBE7IIjz+7bWI3QlwAOdeHi72hO9DrDAQXVhfxGeaw7An98ley0
         h8RdgxEUFkQBXHoXlrB5gPnH9vDo9CAg1U5Em4AfAL6h/iYPGEFYjPeT0/wLdlo0xpOS
         YkB4bH/ukybZOxrma2DGhNLRsc0VauYmEnm51auVSEIuHi84vGPh8VMSxfDFarQM9Smi
         CUu63vXM5g5twHy4qQCQ92snBchUQ/tNUBJ8P07Dfec9OO5ZEDHOTtBuwbd/1EXTqd65
         PU5w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ73VH02vc8fka5cmamUlwdK/Zb52ZC+ZUnRphtTzXpsVzydEdHRJJ0ut9kegJ3CDiLWvF2dWjB9Pd5Q==@vger.kernel.org, AJvYcCVERj7Vl2Ss74o4x/C9aqf5PLLjf0MetO/moKJRc/93wZqdTN6OPYHdty03lgTie3X+weF+XFJ1Ba6yClj0@vger.kernel.org
X-Gm-Message-State: AOJu0Yweqoce+OMAZ89ZbX5+541P21l10AioHCWZUU+Nx1avgdAMN88R
	PaR56sMjgIcYuQwhG+F99vKsZS5eh1ETkjFPxmUDp7h/mZEQ8rhr
X-Gm-Gg: ASbGncuuAzqGdYdHfJY2GGj0NP4Jn4PvQCFU7ptwMQyLuyRBfqvic9yxHO2OglzkuBR
	7M/qBsqAmRyV6lXaW6sBdHqqup2CeLHbAzS3l2OmtYaNiBqaxjgVvblOMQ89t9yIIrhD6q+/iXz
	WTV6aEew2ulA+PvwHytuH5ZB7QK2Ony/OCuYZR5k6AMjDZHtaBpx5J15IScbKtX/BX35WyyrkwR
	qSGeYbiYPnBALB7LV6WC0NrQ7C4626qh+R6mQnPIZ9stBhTmEA380rX0mqK6/yscZwcmr2vJB2u
	OvQrwc62b7WM/RY5NLJwE3NVBzKCZ8Vn4G33pl5YDtjuZA0ICQHDXIc9eGmlz8c3/7G6VfwQ7Ec
	4CHJ2zkH8ro89GTkNHBPMYd3XGIc=
X-Google-Smtp-Source: AGHT+IHaroktYIfi6PmvIrlwnrxi6g8VwPgIBP/GXGZ0cEbRzq/CrHBCqsEGzIi5WySOmuqZg0JWNg==
X-Received: by 2002:a17:902:d4cc:b0:223:5ada:88ff with SMTP id d9443c01a7336-22592e4289emr94859655ad.24.1741784761481;
        Wed, 12 Mar 2025 06:06:01 -0700 (PDT)
Received: from kernel-Apple-Virtualization-Generic-Platform.. ([2401:4900:8898:8129:deb0:598c:ebb7:dc81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109f64d3sm114641795ad.100.2025.03.12.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:06:00 -0700 (PDT)
From: Subu Dwevedi <messigoatcr7nop@gmail.com>
To: linux@roeck-us.net
Cc: jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	messigoatcr7nop@gmail.com,
	rydberg@bitmath.org
Subject: Re: [PATCH 0/2] Add support for newer macs in applesmc
Date: Wed, 12 Mar 2025 18:35:55 +0530
Message-ID: <20250312130555.1822-1-messigoatcr7nop@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a148578c-0eca-4646-9abc-92684de4b9e1@roeck-us.net>
References: <a148578c-0eca-4646-9abc-92684de4b9e1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I Think you mean the t2linux group, so my code is completly different
from them and i decided to send my patches upstream

