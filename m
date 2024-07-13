Return-Path: <linux-kernel+bounces-251502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F128193059F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E700B219BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1571131BDD;
	Sat, 13 Jul 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BocKxkQ/"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3912E1D2
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720874453; cv=none; b=KvnGcbaIMz0tmmzD//RpYcN1r29cGfAFk83NswNgNbipfDtVkd8xtPxZ5imD8i2e7I3DnDd6E2FG8JycmGW2NFH9foUL+u8UU4WcQRScpQkJhIhzaJYgs4Hef94I3YWDHBm4oHZLWAIJHp/SewgZnq89LSfm+nuk8OBgJjhSNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720874453; c=relaxed/simple;
	bh=4yFSu7XXmhJSzSwUYrnLbemHBPSoslS8OR1+wHBffNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=idF1+zB9SGiQvwg2in9Xc8h/Ha++3o68vdsl6GReYR6ZrQL+0onrB+sKqpz/h5JJ7PGw9yKjz0mx9KpUPa3twZUc74CtOIH7CpjOw3wercAWRCeg4jlZvv6DbdWgvb+6H3LbMUHfO0Se9VKyndOrdh2LO+PyuzWoce+gB59u7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BocKxkQ/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eea0cbc96bso3446681fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720874449; x=1721479249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev9MEMcim44wSH4EZqGa+LQX0BIyzafscHDCWffwRWI=;
        b=BocKxkQ/HzQcpANfCO5t4JmrzMAHxH5Y8yw7LEbnv7wVQima6z1FIJR6H+I5VFLKxj
         b1jqpKCNgZrgrG+vE5qZiKP+PvkXJZRmxm4OSP8p8dKsUntHjoID36zdfWHGg7gpqKG3
         3Zw9H51p7SanxmuulCVD2Yp9Yv/tRLAgxYtwEKQvgmr3h/eniyCHBa1OmaG/z1mFT4HJ
         P+AGsaTT14W/vIE5FBI/Qz4+RDHvFCLyHwdX0YBBHZ8gtxk9sm+SW1RscVs4DlrDn0Qc
         S++NoikIXvnNIXQFStEEsWx0MxMM2yHF08D6MWCplKmbLXzepz3H8c5Gggf8MGfMXTSs
         MC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720874449; x=1721479249;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev9MEMcim44wSH4EZqGa+LQX0BIyzafscHDCWffwRWI=;
        b=pHl5w6fg8Fwtzr4XpVEtNAmR4XkC40oZ6zALIrib3e1lbfImzAZb662Cj5TnBl5b6e
         J8wUX9EBXgH8VPrHSbUnbjB2oI97hsk3vshJBNELtWJcte+2VCh5HLmMFerbrS1vJzN2
         YlJ2OaWovUO0W/9vUTGXq7XdZdtt2nlelgYsgZIrh4BrUxjaf6bmv884d9BWLCsyzbwj
         cTm6EG6/fOQ9LNIukaO80OHpJtHnOmLQLADDRKKulSThlDHAbW9Dr+vOB19BufDh8euX
         Wvb48hSps80mlExzJt52cQlskpeUQJNjI7m3snXJYXV2tyrBgA9tAlJIrT2KXzI3HU0+
         wMMQ==
X-Gm-Message-State: AOJu0Yym2DBwHxkP175BJozLHHDibTVoHAa6+36ZHgiGwAL4WomZRdch
	PQbhks5AMTbnOXinhp4475KAqvxuKmWm/tic8CbW0jXlIV36hFvL2LfNI7ae4iA=
X-Google-Smtp-Source: AGHT+IEDmDpZI2HOW9VBq0n2GsPSGvdL5UM+HjYSsiEoOGG4Tzgtwq9ejM87FCvZTWOzaPyOAXNkUQ==
X-Received: by 2002:ac2:5b04:0:b0:52c:dc76:4876 with SMTP id 2adb3069b0e04-52ec3faf952mr3591414e87.6.1720874449263;
        Sat, 13 Jul 2024 05:40:49 -0700 (PDT)
Received: from [127.0.0.1] ([2a02:aa7:464b:1644:7862:56e0:794e:2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed252d6a1sm177225e87.175.2024.07.13.05.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 05:40:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: syzbot <syzbot+1e811482aa2c70afa9a0@syzkaller.appspotmail.com>, 
 io-uring@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <903da529-eaa3-43ef-ae41-d30f376c60cc@I-love.SAKURA.ne.jp>
References: <0000000000007b7ce6061d1caec0@google.com>
 <903da529-eaa3-43ef-ae41-d30f376c60cc@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] io_uring: Check socket is valid in
 io_bind()/io_listen()
Message-Id: <172087444804.7272.17982342612300126690.b4-ty@kernel.dk>
Date: Sat, 13 Jul 2024 06:40:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sat, 13 Jul 2024 19:05:02 +0900, Tetsuo Handa wrote:
> We need to check that sock_from_file(req->file) != NULL.
> 
> 

Applied, thanks!

[1/1] io_uring: Check socket is valid in io_bind()/io_listen()
      commit: ad00e629145b2b9f0d78aa46e204a9df7d628978

Best regards,
-- 
Jens Axboe




