Return-Path: <linux-kernel+bounces-378979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FA9AD815
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED501F2537F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391081A0BE5;
	Wed, 23 Oct 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzzmfIag"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED294D599
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723722; cv=none; b=CSI6pDVoAqV564q7rsSRnoiAs0ZuG9JiSPHgWdICmIqpijB4AFIcBZ0wmPA7FSEjzIvocumx6ye6Gk3uKy80t0MoNtpGgyW3I9NnrY3EEll2O2oGfVYav1hd4ru7r9V21hA8pbU2/J10cTIGvat168x+MqN22jQp4HA9aLBCwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723722; c=relaxed/simple;
	bh=wxpDHQwrwGkzB2vQpCqlwlMvsNeLE2V/UsRqjafQXsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cinkJtH0LwjubD6wfmJLigHc9w8Lnnr+zHplA8kZU3dl2xrGZbkWpEpmA6m1lTZcwl79o7AU5JIQl9+qH5RWobsLVNWE9CcXbkmtnsFU/jr16kGh2snMBwKqdO93XAQC6T+YXEQX60xiEBej/T+MhSO4Nx0xmUBshSLRzotN6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzzmfIag; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c714cd9c8so2477565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729723720; x=1730328520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvfx4hhe8sNGyNx+56x8PO6ko62UBrDG29CxfNFOdpY=;
        b=QzzmfIageglckblK20OPjsdGAFlnd/PHX1/31qXv9UeqKxjIH/O3OY0/xK0qWLGsvE
         WQdtyD/HH8EwurGo0TgkLgHD9hBwweIImn0mNwD53GjZk+td6J5FsgS+oDiqsp0o9aa+
         adOzQ5viAsNV7Qx6lTPVIyg26LmVULXf8jftlsFP1uW9BToNYHVkYG8/R9HEak6qSeGT
         71crVQWVH8KWKK6/Jg3shMffR3QGom2IZBEhXpHLNGJFM7J7GUIFqxMGgZaYq81LAXmq
         cWIu7D8h1ZXhWuc8UUE6KeVVVsqhGZcedDLWe1HbxjmK1TtWRlz6kqGiz1DNKtP3MqhH
         TrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723720; x=1730328520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pvfx4hhe8sNGyNx+56x8PO6ko62UBrDG29CxfNFOdpY=;
        b=UbC5+aK8UdylZf0ylPRwsqxLLlMzpXN/W1Zu1darZbzTZt7YikYSoUwHI25EWz5J26
         Zlr2PMvbqkP9qEqQcJ2TVyPSR1LeyEG+7DNC+L/2C24gCnYyG1qo5aHkFeOf5Ty67pQV
         J/53DhuCYiuL0ldbaoqp+ATq13Yqhv3E8sH4HmQhLGK+a2LZcaq8vMIy2xq/U7BSGqpm
         BEz3L1OqAHym/2AG0RW8aXruWR7S6dDoPzQtXRKntGEdWsikwh14+l7svdviI5kAQBwr
         1CxhL/SPHXqIiogNYXOERrfEt35KQAHK+EMXRbDcm9eWQ1iHEmZQKcUx1iigYnGwEtJx
         wj3w==
X-Forwarded-Encrypted: i=1; AJvYcCXC5GNUhkjnnnjBea2iJyJPAKH/aBl0W6CFg4PPKTt89K7ty/KHZ6MU+VefH8JhH72KPretD0G+in4Rszo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2XjIcy/thNryOooDUYifKvWKAiI4GpEzObGmYUuXDF3H6ts+
	ojFRoOHXlmT0pcnAvLCwjzDY0Ain2jkYKE1tk1CwDiIQ54lfSJbsvft/uw==
X-Google-Smtp-Source: AGHT+IGZbCiqEOLJCUMgl47AYJePcJt9+VznTxqIG6dPlRBIZFF9qzG7zlv+Ql3cSN/QG0kbsb5Luw==
X-Received: by 2002:a17:902:da84:b0:20f:aee9:d8b8 with SMTP id d9443c01a7336-20faee9dee5mr38522305ad.20.1729723720180;
        Wed, 23 Oct 2024 15:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:97bb:b4e6:f236:f01a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0c0ee1sm62196325ad.160.2024.10.23.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:48:39 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: rodrigo.gobbi.7@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: staging: rtl8723bs: change remaining printk to proper api
Date: Wed, 23 Oct 2024 19:48:33 -0300
Message-Id: <20241023224833.12770-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022031825.309568-1-rodrigo.gobbi.7@gmail.com>
References: <20241022031825.309568-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all, 
Please, ignore this patch, I've noticed now that I've missed
some places for netdev_dbg() usage. I'll submit a v3.
Sorry for that.

Tks and regards.

