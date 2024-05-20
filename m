Return-Path: <linux-kernel+bounces-183965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7648CA0B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB343281F70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F4137932;
	Mon, 20 May 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XLU9qgMU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336D136986
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222483; cv=none; b=bR8G5KWf+ko7Lcbe+CwLCrtKMeJzQ+9QindHpdu0DI7zykHxE5tZQ03dKsJ6H1o5cj58siniaKT6awWc+VN/5Cs+07iBodHw7ILP4D7APX0z+itdSPCM72Q5Z+PWOXIVNbgLfpKUIoJb3ZNes0pHm2XeLisrryBioQFi01LVH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222483; c=relaxed/simple;
	bh=3tlsAKIHnQ7N5j9Kl+sGdZtctZZ3NVmBDPxZzF3lciA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYWdKl+7+izqNq7lwMBtfgjzSFFszzLG+BBM/FdjaWWjKV5Kkb8tsEoRhr903JrY6N6eANsRu5PvoKxY7YJPTgFMvojVQOOcKJDzTHmx0FSigPdHDyljaSvz1egMYGWOYkNYhwzH8lopNcSsk7ruswF55CCSEZN0g46rG+ttZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XLU9qgMU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so7477773a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716222479; x=1716827279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGDIds/r/clpOnjfbNYzhaZkRFkUlCVg5hhWH7aO+Q0=;
        b=XLU9qgMU5cnLtJF+zQPDq59DT9xpOFB25sgK8g1uuWkEyaSthJe2oyI4OO+Qlwg9bl
         5AVoe98fQbe9S4hudDiKf49Mv5pTcDD2zT3/p6D2CkEPHKZ/YmegQutsgJL5HlYt9Sr6
         1bSD80hl487g4cTm01YRKWxNRX2po56eKr0dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716222479; x=1716827279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGDIds/r/clpOnjfbNYzhaZkRFkUlCVg5hhWH7aO+Q0=;
        b=t9OJQ1D6EumZ2afTihbTYWctoJL7DqlrTaRrtr6eJ9WtpyPg7xYyFnTr9MTAdhbMEG
         fMRjH7QNiR8nTmbP7spk0Xg59Rww9IZLxLNP0a/yd8UR6vHgyF48cVwgUB2p1VeE2SYh
         YeqV3RXqTZA6/W8k+ZcZK4AV8EbEWfAkTRep0hEVFivL0Sq3VQ97+hTRhZEroTD2Qskl
         LKVexQF9VjyPYOJhMAacnlsfMMU6cfRRpOORaW1udVeOIRRGB9SAM3tc42OpNzSh2G9W
         XgiA5CXwKTDq8DwKaA/3v8ys9SOSSUULdBgJcfyFn5cMEpfQD7VtDL2kysj+EqjnjcW0
         Pb0A==
X-Gm-Message-State: AOJu0YxHEEUona+QMnC6mx37ye7FDKAIcjD76i/gRzgyHHCL00FiVKLM
	CQSXhIRHa4KE93nx9kU8Hg74c7yf9ZD6xe0d+5MjYNCZjKcoez30NpdhxPyAiKRG4mWv3NZLRxC
	qKOUwvA==
X-Google-Smtp-Source: AGHT+IFJVBRr2BWm77rRZCu0ryGtFfH8m84DckkazlsTd+O20p+uNjSiTHdnzvoLnuX4KdXT9apnmA==
X-Received: by 2002:a17:907:3f8a:b0:a59:cf38:5338 with SMTP id a640c23a62f3a-a5a2d55ad95mr2475159266b.19.1716222479412;
        Mon, 20 May 2024 09:27:59 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d70sm1459789066b.125.2024.05.20.09.27.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 09:27:59 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59b097b202so552386766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:27:58 -0700 (PDT)
X-Received: by 2002:a17:906:8a50:b0:a5a:a2b6:ba8f with SMTP id
 a640c23a62f3a-a5aa2b6bf36mr1097048166b.0.1716222478608; Mon, 20 May 2024
 09:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520101221.463a1ec8@endymion.delvare>
In-Reply-To: <20240520101221.463a1ec8@endymion.delvare>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 May 2024 09:27:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxtT0O7yGX2n=Y3LQ0zJ0c8ZeYZDcbHfFOEiWHFp+qrQ@mail.gmail.com>
Message-ID: <CAHk-=whxtT0O7yGX2n=Y3LQ0zJ0c8ZeYZDcbHfFOEiWHFp+qrQ@mail.gmail.com>
Subject: Re: [GIT PULL] dmi update for v6.10
To: Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 01:12, Jean Delvare <jdelvare@suse.de> wrote:
>
> * Bug fixes:
>   - KCFI violation in dmi-id
>   - Panic on broken (short) DMI table entry

Well, I wasn't going to pull that based on the description, but it
turns out it's not a panic at all, it's just a "stop decoding".

Because panicking on broken firmware would be horrible.

           Linus

