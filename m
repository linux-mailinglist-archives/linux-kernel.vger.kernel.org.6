Return-Path: <linux-kernel+bounces-337620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A877D984C85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F641F23BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CD13C3D3;
	Tue, 24 Sep 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K/swazZa"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB613A3F0
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212008; cv=none; b=sL43UJYN+6G3lT/UH1DTumfkdqvIxOkbskMvUMShSr2WCyeqs4VStC7xoGhs8mBz84nNj8QoDZk6IOC2Gdu3aZjgwaaMe4cUTMmcukIAJbxJFeCnQtBz+6Ljo+DF9aQ7W/JHTJCW8TnEbZMOVMVlZZmPBt2prUudQeKUuAyIsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212008; c=relaxed/simple;
	bh=duiQhgIpdYt0fr4EBf9j6/V+Y6v9sOYJHzZbM3O7qyM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nh3mB1K+8UBmL0v4ahoiyqlCAnJ8uTGB5fvfaFwN6Ei9GFq5VYbC9qtFhBSbiQW+2CDyvUqC+a5U5t0ZGdQ1LLfPMlC8xquOPCl/KHYcboU5Wa+0IOZa4dxkDazyAO+xpAoo0BWrF2KrZleh+vZxXFVNQnpAo+//3D5aULZ63qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K/swazZa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205909afad3so68439405ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727212006; x=1727816806; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cOSRCTldnYmAEoOT+PgzbC1WcHMLOlX9r7cKBA/cm4=;
        b=K/swazZayGJF0QHOQE6+Mez6T9gYG9QHzroTdf0lTHntyOnk3wU96kHtmjDfAwT37e
         YWsmflDkRx9tpv2Gy45CDWWJH9RNB84P5zo1ZauGsfFIvoEYFXTOa8063+0AadGb9/rZ
         TnLW5+CmLFgAHWIHh1LqoE6VWM595Ga89c1Ta0f2CEjL0FanhF4VAReP31nfCoXB/P5F
         ea/dSpLXaBABKjWYQIe5n87dgYQEHf2tObd9OzL7MprjAyXY/FhfIf6YG7d8tr3LXBBv
         0t6VAfV6D/MFEPMMs3dlLUsvLkWAioKCSv4hX+fb6UNWwca+CFdSRmNg3H9RiuL775Sf
         8EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212006; x=1727816806;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cOSRCTldnYmAEoOT+PgzbC1WcHMLOlX9r7cKBA/cm4=;
        b=F5lDTqvjOfYLopXdLofumGTTh8AkDnoQerJIAzIat8oO/YiaMKiEkIPTTy8wm9QFPM
         /B74Ty0D2OXLLswl7lmkbyCdEin0k2aFIykSsWav/AgXjo6JT1LHq4R6Z8ABaqZ6LTDH
         5DiFIzZJ4JeWkbsMTMfnU6y/SnGYQN8VECHSj0U6GwD3PS7uXeflfnBc1KFZv0NnwLoj
         3ZkvuXr7AaVp9uxW2xZY9tkIIwVl8q2RHXRPvmGte4elM9AVRpzE60NCPz9TRSOWpya6
         LAj7wo/yVoN56ANyVUsK3ucIpuOLp+eGwqnO/T8JsIxY3ESvGyi+YliVktXhch4+XkWf
         HDSA==
X-Forwarded-Encrypted: i=1; AJvYcCWerE5v4f4WUUh5UvqYknOsFf3SSUWQJbJyuTvzmKBypQK0wqDQt5sYU6LJ84P/3qrcf6Xs676bubNySUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw4edH8PInf0rrglcpIF5gt2M9X4E1NBJfQT2lIJFrbHcWjlk
	LlJqVwJXsiQBVN3tBQVA1VApNiS4BNvx/H0xdF9OaB++lFkW0nn1Z5lDk+1uENc=
X-Google-Smtp-Source: AGHT+IGhyzhT4ItbLkXqJFOEF/QVw8PfECiY10lnETHANlsD8HmM/Se5SFVUhHSAQcwZL7gQfWEuoA==
X-Received: by 2002:a17:902:f60c:b0:205:826e:6a13 with SMTP id d9443c01a7336-20afc5f07damr7240965ad.54.1727212005646;
        Tue, 24 Sep 2024 14:06:45 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20af1818f69sm13717095ad.184.2024.09.24.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:06:45 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] igb: Do not bring the device up after non-fatal error
Date: Tue, 24 Sep 2024 15:06:00 -0600
Message-Id: <20240924210604.123175-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes:
- Changed dev_info() to dev_dbg() as suggested.

v1: https://lore.kernel.org/all/20240923212218.116979-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  igb: Do not bring the device up after non-fatal error

 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.45.2


