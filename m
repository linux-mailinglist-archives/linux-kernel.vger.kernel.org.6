Return-Path: <linux-kernel+bounces-359186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA5B998874
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9881C22FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358BE1C9DE9;
	Thu, 10 Oct 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbMQcthj"
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4F1C2DD5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568584; cv=none; b=IKOi4l8GThG+VwpKhDCZeh73GU7TEHQNayQeSR9jZ+Ljsf53Zvo7erTPqlSGzTE0E3roF4ve9MJrlTTHxac2QpAjrRP0WJ6dNVgjzeN1rbzSVgUYHevpzgKZgAFTuLhoyqG5pXEwrlFj6OIB1B0Kf+Yo/Y6vk4eBp0RBQcL3UtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568584; c=relaxed/simple;
	bh=17AwFvAkvJTc4jkkwP9uZww1kD3c4XBeoOsTn5Mu1W4=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=CIWtczqWeYZ5f89qOCUthiwiHdwzSX/wyAmqtSCgOhCVtGt1xTqTJG8seNVAVCE91LhpEx979/j2ZyzfvAWmIURU81wJOvD9jf7TibXrPHfPtd3ggQUxg7IjWvSl+KKAKXQrsZLCG4+lX3FbMcfKBv5X/jtPSapuquME7p5dYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbMQcthj; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-717d4ac7e3eso70218a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568582; x=1729173382; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17AwFvAkvJTc4jkkwP9uZww1kD3c4XBeoOsTn5Mu1W4=;
        b=JbMQcthjrqDJ/TMzbG5BJmgLoF3mX8fySxcTpsWGE+sjMxcpKsg9A7ehm5DJaPXTfZ
         gLTkEPCumbZeOmtcvRRLyWIEhOQctOvj5QlodN7EhfMk/w2MqnetaM96F2PrMnsu1vnS
         EMw14pUmurmViBV1kYxrdx++lqr6RVLjjnkZbNxNn50ypetAxuh43D8NkPf4Gg/DKb6n
         yDIZqNoz7dXqELfAoevd5/PhVKY6uUaShBgQUYMlEQGb7297m0s63TXMj/ZqWiBQfRII
         ssb4sY+wstM0K1xBXLWM+J+eLye9+UzkWOMySKbETIB8dDCZTHXKjvqFT4ObkUmGv6cA
         P6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568582; x=1729173382;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17AwFvAkvJTc4jkkwP9uZww1kD3c4XBeoOsTn5Mu1W4=;
        b=CjsAT41a6LRwxxLJCBIiKbh27D/wLLle9JLit15E5eigHpmzklczAh0tY+Ijh59IVK
         21eoTtiM2ZME6fbiMg4NZ1/dKV9WhHZsRiI8W6cqaeDfBIXadvsT9/j20xDzaqzzuTDy
         PAzdY9uQQwg1xwKQSAEHWkECUksbnbUO8Mp01Or0rHogyNuazZPv4mjoY4LCvUkZ6OQB
         gNtoSMO3h6h63tz9USgT7HiigFB7Da7kcpIGoxNalvnoNsjwT97rpyYqgnUKNbaJnKzA
         WoKhzt99sNl8jJDh1XIG02QtYXdgqxl86YZITcHHbqGAFRDKuzmpiAuzP+YIq4Kthb5I
         jO6g==
X-Gm-Message-State: AOJu0YzGcWxZa2SStEmDU99wWt3rgfi0WZobOxm1BOmMPTBdmHhbXhhO
	3WyEYgsLvmWlTXxnUbkxO0SRy7sKxf/s5rCOEeW8t7zbPz1Exs6URjU5wlvt
X-Google-Smtp-Source: AGHT+IEIrACafXJRsKuomLkzbTMFu5ne5lAmGVQoePC/UrpdYtO55KE3k4zUKnxlZsZMCE40qNmFzA==
X-Received: by 2002:a05:6830:314f:b0:710:fe98:ab5c with SMTP id 46e09a7af769-716aaa78c4bmr1436727a34.2.1728568581904;
        Thu, 10 Oct 2024 06:56:21 -0700 (PDT)
Received: from [178.236.246.42] ([178.236.246.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717cfed5f6asm190444a34.10.2024.10.10.06.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:56:21 -0700 (PDT)
From: Barr John Marsha <cisseayouba09@gmail.com>
X-Google-Original-From: Barr John Marsha <info@lancastermoveable.com>
Message-ID: <88d3b8745739ce5725443e3128463e7cd1fe41e340f28db4ac4edbe8b7693bcb@mx.google.com>
Reply-To: johnmarsha@arnoldporrter.com
To: linux-kernel@vger.kernel.org
Subject: Vendor Invitation
Date: Thu, 10 Oct 2024 15:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Attn: Sir,
I am Barrister John marshal (ARNOLD AND PORTER LAW FIrm)

British Petroleum (BP) has invited your company to participate in our 2024/2025 Vendor/Contractor Partnership registration projects.

These projects are open for all companies around the world. If you have intention to participate in the process, please confirm your interest by asking for Vendor Questionnaire and EOI.

Your prompt response would be greatly appreciated as it will help us expedite the vendor/contractor selection process.

We look forward to working with you!

Best Regard,


