Return-Path: <linux-kernel+bounces-341380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A9987F43
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE45B1C20AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44BF17E000;
	Fri, 27 Sep 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYFwDvC/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34D1D5ADE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421605; cv=none; b=JfWt0ApLt4la1N9KDSQenFkj9g9jLdTuf6XWf2hVR1Y2ojuoAJXn9asJRWOfzl8Q0wEMWZi9E71woFDU010pRZD5qabid9zKV4dontSrvi3kvxK0VvuuxWDa7lRvpKHPCSO7WyKtv+V//7zPhM66iedPH+vtw2oaqpS7eHEG0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421605; c=relaxed/simple;
	bh=UUer5AsU0EapduGbbVyKKaf43fdmVgfcN66T6aF1Q4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z05n2kMPfK1SrT+1rVxMbpHm8Vgo2PwbroqL0UaT3+3Y3ZlUwT6PtWMxEDW1uIKoFLISFa9hVCCKb55VE+CWurxlQqa0izy0KPkVG6GgqaCfQob00liWEHEsNkvoO4alhxZROsK/CVw3ldzsBvH8wJsnfPgsitkUKgIba+Vj8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYFwDvC/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so743639f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727421602; x=1728026402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUer5AsU0EapduGbbVyKKaf43fdmVgfcN66T6aF1Q4M=;
        b=yYFwDvC/zymG0ut07yu3u9MELIZW3rRFgusdg3uljrqmEFr6YT2AkXQWLUUv9LUvqn
         Neh0J07+pTWaehz7fYIvZ2A2yYxXCT7ZdAFvIM5Gp0gflcQnvUySQbeFCMJLr91ZaAxb
         Vhr14odb+2uYLGkIDZ852Saws+/CS053zogjoIjzq7AOVmvcVqey5irFJEtmHc6X1zx/
         kXbUrXUI+Yk9nMxoCqw1TEhPYSGx7dNhCc0gX5jAJ2RfREIg/T9BRoePQqJA7rrvFEJP
         tHeNzww7R13ucyPIgX3ksd2Zkfx9ljldAN52C+uFBIHtdWPPituirqGIt1QBNb/Gj6EJ
         mN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421602; x=1728026402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUer5AsU0EapduGbbVyKKaf43fdmVgfcN66T6aF1Q4M=;
        b=o8a4VuJGcwzGpaCkKk0KxgnAIQ4qBVfX0Mc9m0GPx1ZrxvMjsz2DpmLYhzqzAnqplJ
         eE4WRUxbgT0Jz/j0wgWD4hJTctHuNsDxy749y8YD1XqXep1jGIAV2ZNwgGG0y2xfiZY4
         jBI/FA1RwWpByZHR3SfctPD61YRXL+71waA2d3Ys0WHv8w5ttBGCg622gwJAOEB6d5Fy
         01FI+jtrpGV6Jf3bP6Wh+yRG5K9+mHoQXDbOKQ1ugFpvpOVNYR8uiCAR5YRJN5GeR1IP
         x5rhih5+y+NZ/qWoSwzTtFc3/fBHdd5KHyvUsvCvFhoka36mC21RfghwoRofLv++orYC
         Gq6w==
X-Forwarded-Encrypted: i=1; AJvYcCVtnE2ONO+ZWihhms7Kd3sP3ngeWq8MSiHqXopNgBxZkzceEbp99qQkMTMzVdRZuqpTcUjSgAw5ZlmQbZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9R2qO45GBj/FBw1Ru1a/Mcj1cRO61ofge1FEhUuMeMRjcjFt
	x+/ajyEpXQVokwKFpXXlXxtaiOxHpRCnnzFTUcVm+FiijMiV+gu9x6TVWr8kuYwl/O5dHJH3nNC
	4LCSBdW6JQkmFBwUs1gH1QblpF96bk/FNmlXX
X-Google-Smtp-Source: AGHT+IFDjmGSn5W7hvNBqPXKxR5dvdDqGDDzbiagFCPcdJ+stGo59h9JFQ1gTQgOukiRs4WwBDXmp/Tlduf4VHIEEDg=
X-Received: by 2002:a5d:4e07:0:b0:374:bb1a:eebb with SMTP id
 ffacd0b85a97d-37cd56dfb91mr1412551f8f.25.1727421602051; Fri, 27 Sep 2024
 00:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-9-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-9-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:19:50 +0200
Message-ID: <CAH5fLgg=yYNFzsM=Jj5ALtKgaza+rXord-yg08_nDM15T15w0Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] binder: add delivered_freeze to debugfs output
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Add the pending proc->delivered_freeze work to the debugfs output. This
> information was omitted in the original implementation of the freeze
> notification and can be valuable for debugging issues.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

