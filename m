Return-Path: <linux-kernel+bounces-363419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6099C233
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFAB245F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295814F9F3;
	Mon, 14 Oct 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evFClWSq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E614F9EB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892488; cv=none; b=AI9m2cz+l96oRwS5xVBMsA3HtySZSy9w0OSXl3TkhjJLvBC2tkkoFvPJt7LS5lB4GESR9xc1SZwSQcu8nYe0eTRweBkngiunJKbtJnFscocbjtdfl+nbG92wkobhdTbopV2m3jOei002kxwsENcD5wf08qdEy3/pNtvSnKEKbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892488; c=relaxed/simple;
	bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=F2SwfiuxFwM6YDdXxoq3/GREPnVEIWpiJ4SVi452D1oJk041EMPyXjt6PVdqv+lNOjsME4Z6sUjBtcmlUiM+CadP0GeCR5Y3CvvyWZHfDbYh8Y5lHG5mSp+0G4b78kmwT7OZHiXaJDBgUyp3z8mAHFck7KTfjVvdotsxvjDloJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evFClWSq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caea61132so22025315ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728892486; x=1729497286; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=evFClWSqKhgK9PskQmfYoz1zv8Oy/IHKs0/7lWDsQLs/SdApjuXdK914GtwzmY2R7T
         xNip0syetJc5ljzqawy2Y8ABaNuynJ2sr0pfoz+9MGu+T8XOXCG1z5xnCUMSOPXvjr13
         zKmsylrwYBfW2VpLjXbvesTNj4wc5pOMuAKIngcYU/kWN8J+j4F89UIml9ypdSOxplh6
         vMFzgUf5rrXWf5j8cAMaAnxIVChovVKeV0H1SRKKD1OGXZ1cdmQrOkYPJhl8jAIqc12E
         WcYueeWQHu0GYQhBI1nuJsnTJ6flvqyi0SfHjFSkVGRdYpi9m6OhkQi42CppdUOu+TYf
         3SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892486; x=1729497286;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=hhYqUHENrlfrxv53LeN+wwux1JLmHhr5m1GxyBaOMnAHrlVmKdipbM04vXEICE8Iot
         oCpUd4+6nQ6t/+A09PqQ3ppP9ZenCo5yCc9X7TdTf8RVifTa6nXfHIfovDMKLQwpBo34
         5NXxzrRgPmWo43XTq04KeS5nvkpczwM24Un/XlgiXjVpYiglazCfQYTO7N+TasJ2hNPq
         +j2D9bCgI5FjwVvCSx0r08zQJT0olZkNFt33ZGHQidKxMjsd+u73VQX8MnZFBOhnEacE
         hx8uNNlFhGAIX/iVJPBAxmmHCjYIiZ+vXGFLJfF44CKpZGc0vvzCzysg+XIslfrkbgk1
         0PJg==
X-Gm-Message-State: AOJu0YyEsNTkO8s9PzHGh86BJZa0U0N1mJLvW/q+nffPJAVLUWjLa1bz
	zRCfMQLwrYNFg9QOtWtNrGH8DnKCNAjihFOGyaKFCwsaMWszNKgkLnXk0w==
X-Google-Smtp-Source: AGHT+IGAPwz0TaHtOcgnkb7Gw0y8hMH2OZQfGs7o07JXVnLQfzN3aZOlnTO8RRYZA6zLePtXGNQB0g==
X-Received: by 2002:a17:902:ce87:b0:20c:8b10:9660 with SMTP id d9443c01a7336-20cbb2845dcmr127337465ad.44.1728892485758;
        Mon, 14 Oct 2024 00:54:45 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21643fsm60280185ad.221.2024.10.14.00.54.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 00:54:45 -0700 (PDT)
From: Debbie Magoffin <eklaemon5522@gmail.com>
X-Google-Original-From: Debbie Magoffin <dmagoffin@outlook.com>
Message-ID: <5d254b2f3b7952bdf8fcbe8a301c182352670dc2a4b078e603d17777dd0484f6@mx.google.com>
Reply-To: dmagoffin@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Yamaha Piano 10/14
Date: Mon, 14 Oct 2024 03:54:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please do not hesitate to contact me.

Warm regards,
Debbie

