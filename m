Return-Path: <linux-kernel+bounces-544375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7EA4E086
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0BF1762CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E794205AB7;
	Tue,  4 Mar 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2lSlfADE"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80720551B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097790; cv=none; b=ZLNAtjtdMubuVD3e1LwciTcVVNNUpNX6ziv1X/pJMEh383Aub/fgKIe+lkEXZaUlt4uRvtfZDEQjbi+iugkgnF+SnAFFYXA2sWxeO544wleVdlimMhPq6MrpEBm9kkpw0qEdAf1vOX0v8wkPjhWiZAylNhqoqINZg7t1aIqedQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097790; c=relaxed/simple;
	bh=ZZ+tUxCQ5Vq6r5SZVC9DDT1JjV/LpKtO0cS1gMILap8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g74rXz5Ln/PLozF/G6fQ6ve/e/iXj2gzhdEwVt/ZAF8IBt0v29xd3xkmYcWxLzOibVjv9Mb/GcvxLBtP/qForZ6CJnQzpHbB/T8LXEsaSgY2BXVHaL3cieAwDBzUyHFP1GU88YRA35LvOwe9FuKOiqkqiOZ3cG3vmUpkTYT4WKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2lSlfADE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso17943235ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741097787; x=1741702587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMyl+oxcOIKmILwJnWXb5CChyFyffMt+pqOQjpq2JwQ=;
        b=2lSlfADEvmqLIr7E45M9jUEpVQIJtOMqq+yklTgdHvLx9ui7E92bCxWZI4cVXGleGJ
         GOsST3UPyZizVXjJ54Dyu5AfnHwIJ6F8NUSFOnW40XssUKOjhA1Obg0DgLEJTVjfoMcU
         MweqQubqEc1kI1nnYNmgG3nb32JhAqSQfJEQigq8BegjiMGF6zHk81ow7i13hbzcHh+g
         h5xKyP54t3LZLxvynULrNtM3cyt5kKF8OPpjEWdSt8gn0mF4E5Yr39OLjL2t//8bcPby
         SGsTYU9fheDKopR4cAKiZch3x8fZ15DcUuSBsl6p1wL8Rtr/jLxRxxAesuU9YfxYVEIy
         Gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097787; x=1741702587;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMyl+oxcOIKmILwJnWXb5CChyFyffMt+pqOQjpq2JwQ=;
        b=ZEi94hbVtOJr/amiOzFJMlDTiPmVf9JEXbKoFUOzV2s0Z/QERGtwEfIGXp/Rzi6P6q
         lIRONAaxwCYBWaXmZTPLtckam1BX/UkNmxl5eFTvwGaERgfAiBptWgQ9EoYSM5yTdQQd
         rZTZ3bDS+WWZ1wtg8ud2MpxhNz4zytOPteEf4udrZUlot2W+D9obVsKe8iPrpOL8vgf0
         NH81YwjbocyYqvRI/DbFCHmLYpLpOCnTR09FHEV2kzcH5iOssOgmaEzkIH/6MN7u0uQB
         m/HxBuH/DMso1ZytfkbYADw+6MdBhcYdmYOGU+jhvaAyEktznJbhIILySKk0rP5KDxW6
         0aVw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Jo8i4QeGFhQ2agSOPTXtVQG5anl4UswZtthPY7MalQonFKepTWie2AFGnIBcxTcqGUHQrDy+RSzgUEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MUaO8JF6+QR56ojwT4djpUN0r24VKqbbRQSPCb9OJj7RBkPL
	fgKTG45jbynAzK4pzMSMp543YL+24hjsBq2W7wB5sdkKRJuh374Wv4GmarhJRmQ=
X-Gm-Gg: ASbGncudnJRMRnq6ZqiqmHNz4AMwBMqmmc58Vx3DFVuIwhFJUXeAdMAHXjzhi/2Zo6u
	csBCtbghZrdzZ6dXteSU2agmHksQZn7V1neHhlgEqb4tdYx6j0Oaom0p6PGu1wvvDIBeT1Yw7X0
	jL5NSCn24N4tudr46zKQNfd5mRwiFAn5DKl2hvnVW4+U6tGf8/gtYWOlBhkBiqPW8sUP5v2f9Ui
	hTl0wULYZEcQqnI1imNnV34x8+MGKrlcHjSXG76EZrJ/XcbbnFkn4uoqJq1myTJTYwT4mG5Ac/m
	HUgUfzklfv75nu96hRpT+E2+iTf6eehd2T8=
X-Google-Smtp-Source: AGHT+IFj8V1lrVTGX1aEmcbIsZIMETt6qEL+1ROpr16ZBa8ONvS9TQnQWeQjOnuK1GtqqTDzWub/ww==
X-Received: by 2002:a92:c8c9:0:b0:3d3:f5fe:fea3 with SMTP id e9e14a558f8ab-3d3f5feff37mr88813775ab.9.1741097787069;
        Tue, 04 Mar 2025 06:16:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f1e668e5ddsm712422173.140.2025.03.04.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:16:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250301190317.950208-1-csander@purestorage.com>
References: <20250301190317.950208-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: don't cast registered buffer index to int
Message-Id: <174109778621.2730103.3690369290810043076.b4-ty@kernel.dk>
Date: Tue, 04 Mar 2025 07:16:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Sat, 01 Mar 2025 12:03:16 -0700, Caleb Sander Mateos wrote:
> io_buffer_register_bvec() takes index as an unsigned int argument, but
> ublk_register_io_buf() casts ub_cmd->addr (a u64) to int. Remove the
> misleading cast and instead pass index as an unsigned value to
> ublk_register_io_buf() and ublk_unregister_io_buf().
> 
> 

Applied, thanks!

[1/1] ublk: don't cast registered buffer index to int
      commit: 9e12d09cfdaf89db894abdad392bb8dcd6c0f464

Best regards,
-- 
Jens Axboe




