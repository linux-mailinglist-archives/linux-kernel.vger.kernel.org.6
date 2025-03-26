Return-Path: <linux-kernel+bounces-576740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20818A713D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1617526D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C801AB52F;
	Wed, 26 Mar 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQpLvIQJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70815381A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981794; cv=none; b=A0R2RlyQRILxCjH50UCONcVfCwZMLXqo3k4C7Gu0cjtKU68nYaI1SWO+x7JM0ANLgIYrXvfTUxByg9slB64zY0FLD36afiRhMxTVMLRirxAvHs6POH3GdiiHYizQ3zLDxqMYLEwupy0wuei55mptnq+aOhYXO/yK1Clk9NAkFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981794; c=relaxed/simple;
	bh=41XofzCZDdQ3muIFfZrbxCbfYMdS/sULdl7mKTywH1I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=c++IYU7Q93DfV27ORz4YInu0zQAFIb20uK/9j+lxSUyu6GmEqgR4BQiNlfclUcaV1UXpiD9JlEAM4Hqqyn8fDRLJkaFdWcsRMQgcGJVudGI2/qRrpVkfSFqtudopHQWl5hqQOiVM/dopcQ/P5wLyGRFLJEheSpFrSyDoi+SVctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQpLvIQJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30c05fd126cso58056121fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742981791; x=1743586591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41XofzCZDdQ3muIFfZrbxCbfYMdS/sULdl7mKTywH1I=;
        b=LQpLvIQJvOpRHI0JUPHJCIHI7JDzQ7+ABfJREVxZngmtulE2ceFo2gWUTgCuCqzlRN
         i9PT6m650YRk3nJiLtwo4MBKJD24eIyqmKG6etaFVG1X5I9HbjllixfYbNX7jX5YkvBv
         OcDqIrIErxc9OiIkGu+0luNZMTWeQOnGuxYC6OE3oOrljntpDUJpk6MQsGorx0GgLPl9
         8SdG+kaZmhDEKPPuO3ZB/56Dvvr6t8CvUDBB8oF5UnbaiAfHY8ShexxRisMMLZ4QDjGB
         Wtqq1OKD9g+v2hoak0QshA/GJNmG3O+p4j5kQ+gpirtXVGcW7gPPKJAQ/zzP9OUWO0ag
         94JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981791; x=1743586591;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41XofzCZDdQ3muIFfZrbxCbfYMdS/sULdl7mKTywH1I=;
        b=LedeAjj2hQ00zPAlbVOQRulEcpg19YdRUlMW+u8AzPTDOyJR9y8OO1BlrM5eBpLz9w
         Z4O+Uwus7VO6r7ykWubMAtGLY1hfgpm0PezRbgpPOLtA9urzfjyU21NvxEgV6zA0EOtz
         XjuGUi9eRByAej6NRJit/S+/FS9yo5QS2/+lrLJ2vyfwBP4NAS7FsonSasL/c1fqp86P
         cKktjoYRqlkaxIpFeNg/IUUqhux/sndbdMe/n2d0Fk4ndbKKWKt6ML8+OJXgvSLMxUor
         BZgCoGuFpNNm+T7tAUEPZTJWMK0J5wYMGcf0D+Judd7c2nlhhe2WbCp+ofMQGHu+2rFT
         PAaw==
X-Gm-Message-State: AOJu0YzwIugu8HnXdireQHPQTvO239JRSfcPnhw3jXjQ/9dHvAD9pgmq
	SMQekDBJdxyk5IMA4X2B+5ZQAvVdDYZB/F0HrprU+ucTfzA/R7f0RrftmchkJ3wngeeajR3yFtk
	dCUz/FjyIQfs1Rbec4Bv1ha01cWc=
X-Gm-Gg: ASbGncsuRTkQB32bUuUAM/uUM8K2DiethQ+XBhTFPU4qrdkBYmHb9g/h3zKpPIe6IQJ
	CbeqrbnKByrCYOj7qaUNRtmldISPQ8VwcPXpMVtsPaS+dPcuq25bzKSq6fDk+4K3hKarD9K9hlh
	LBjarc8iTo59VjghrVCrmdAW1IoC1h
X-Google-Smtp-Source: AGHT+IHVCVzJywQtI7xUtqkGya9R/4lk2Ir0ez0fQvOEygus1ZrNZ+sgrT4TS9VuoYrh4vsQS36mgSGK1NMzGPByF1U=
X-Received: by 2002:a05:6512:350f:b0:54a:fa47:b2a5 with SMTP id
 2adb3069b0e04-54afa47b3bdmr1105871e87.23.1742981790917; Wed, 26 Mar 2025
 02:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 26 Mar 2025 10:35:53 +0100
X-Gm-Features: AQ5f1Joiar9OLwlwiBbZuWU3M4o3psZUGdRn779I-qQ8NF6j2dddDvL3o0PDvto
Message-ID: <CA+icZUV6dLN3qBgzZFFq2gcG3Bssp6UShafLF-3A3BLpGAGt6g@mail.gmail.com>
Subject: [Linus Git] nginx - 403 Forbidden
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, helpdesk@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Konstantin,

I see several ERRORs when reading Linus Git online.

Example:

Merge tag 'x86_cache_for_v6.15' of git://git.kernel.org/pub/scm/linux/kernel/...

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2899aa3973efa3b0a7005cb7fb60475ea0c3b8a0

^^ This one is reproducible.

Best regards,
-Sedat-

