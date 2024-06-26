Return-Path: <linux-kernel+bounces-231546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D557F9199C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AC7283A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CBB19308C;
	Wed, 26 Jun 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCs4TK3Q"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1C14D6EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437311; cv=none; b=dXBOshFWhKoulKgcidGO3tVHIRlLgkU/NqV9Xb/FqAZOArYPvHNdizsFM962SKhLNttIF6WSzhS/CxHgtcL++Q4J0H7vfbwa+pR9+koYQ+XmHw8xRTo0QKSiWS/+aOwVVVNPJ//WtltxAlbrx7IXE80oyvCdi/lDlWvqX9ABbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437311; c=relaxed/simple;
	bh=EN/7R4v6R6eNKenxyUXJC7vHdoYt/NSbVW6zdWQw50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eN8KHlqQOBUAhlBeeGJc6HzFu59jEU10zAbR3wPGBTswDK4cjPwIlBPqt4pn3af04F5WUbwXqh6nnvMx7YwfJYw4l8I8SmrxFZP9Ed95VQclllNQ535Duwiip3WPVBIpRTI31g+N0kS7tg0C0/DB9e3DUxprHnmTx5fDHJGSmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCs4TK3Q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9e2affc8cso45873295ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719437309; x=1720042109; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UJy3VvzdQIqNudEsYqsvd2uBoavgyLb/HFfLMFdVgsM=;
        b=mCs4TK3QsSP4xcxJkEQzy3Y6sziNP+TE88L4R9hixnVOb41IeqRXOkB/hl/iEaWIjK
         PrVjkIOvQvUUG4PzHNfGoXv3KHTdcP5NYX3bHHxBXYLJbxvZ1DIA0+Y2WAJDl5xmFUb/
         sjKkLIYvaOuQ504bHC3TCCL0jZsrFaMcZup0/qdX9sCTt5Ezkx3T5WiWNK3bhkojH2xM
         PD1TYwU06daykVg0aMlmAQKSlHK9Jc+C7QsKwVffUOxjGGw1YtGX3KCrCtUfrklEHiAe
         Igk6fG4zVYJn7yUEQx6LpfXFqG/eO1WZzzfWy2KkPq+2ng5TXiWr5G8Xe5xFVefKcwoe
         KhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719437309; x=1720042109;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJy3VvzdQIqNudEsYqsvd2uBoavgyLb/HFfLMFdVgsM=;
        b=tIMzAun6SvGHimdNxqN6p0N7uthkmvvjoV4gQTNQy7aJSNdCPlIYIVC/FX8C0yOhuh
         my8D8EPBuwAXl9gM4LBDZNQOl+p5U2zUR/MHafwRrc+BMhLTQisVB9f1fIaPpgIhf3W0
         q+JFqeKr6GOvU1ga9nlP5Of8ea7sCYgueAQSy7Vl7gnoO60pVqKw4lH942EMIz31eKMW
         3KHihI/UNEig5NS/jY33uasqanxcJ8X9OHtrZbvbc4khmUC5T0iORxDrpkJRH/2MnSeJ
         C1lUvpHG6bEc7OmVyMaknnIzn5GnRX+KVsriPZwWKh4VYrxy/TzpqnkeL/LzKty1je/Y
         hcnw==
X-Gm-Message-State: AOJu0YwxRwznJpmR7wN94kc8T1L+WVYN3nLKnOZBQYYXbEsfHqnNO2ZG
	jlKuFe6s9xuf/Fzi6J7gP9RJdd2Bs6Ch2tz2VwJkhCh7i7i9V1aZRJyg4A==
X-Google-Smtp-Source: AGHT+IHHfqm2EjVzSU5OdMkYSqoqbdyx07+qCsR/P5i+LbYfERRVRs5QuBAg3/X2Arv+3ZzTyTLLAA==
X-Received: by 2002:a17:902:f54c:b0:1f9:ddea:451d with SMTP id d9443c01a7336-1fa23bdf3b8mr122492035ad.3.1719437308184;
        Wed, 26 Jun 2024 14:28:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c60a5sm103865655ad.153.2024.06.26.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:28:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2024 11:28:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Fixes for v6.10-rc5
Message-ID: <ZnyH-lGLwc37I0xK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6:

  Merge tag 'cocci-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2024-05-20 16:00:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10-rc5-fixes

for you to fetch changes up to 231035f18d6b80e5c28732a20872398116a54ecd:

  workqueue: Increase worker desc's length to 32 (2024-06-07 06:24:16 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.10-rc5

Two patches to fix kworker name formatting.

----------------------------------------------------------------
Tejun Heo (1):
      workqueue: Refactor worker ID formatting and make wq_worker_comm() use full ID string

Wenchao Hao (1):
      workqueue: Increase worker desc's length to 32

 include/linux/workqueue.h |  2 +-
 kernel/workqueue.c        | 51 +++++++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 18 deletions(-)

-- 
tejun

