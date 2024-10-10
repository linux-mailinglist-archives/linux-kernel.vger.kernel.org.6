Return-Path: <linux-kernel+bounces-359853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CAF9991B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0DB2726B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D551CEEB9;
	Thu, 10 Oct 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0ZL8ssr"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502001E00B6;
	Thu, 10 Oct 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585600; cv=none; b=t0cZiLriMxLC9CjioZcaB0FUNjGKqHeED4fh3ePiVp8JmlJ1dYbiLsZz7sYij2D1Lj3T/TYM0DS1oIog5c+7XtZlwlbxGIAmojjp10g28FVuyJVgPkzZIxpNKFjke3k3gJMLEssDknzmn+PyVimNWrMPm7C5c/BEcoYxGI15QO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585600; c=relaxed/simple;
	bh=vt0d7PTWUJpwYF67FaqTOwRZSMHKQVroP6ADdcxk0tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm7miGOYM259oJpcyJf3cSsd12uyq7e7h2XIK+B+pc0o70fAY1bVXMC93B5LHDPynNVJU9QlM9EZf8ceovxe5/gUfPLJWkmfJvnwQIgPptXYnv7Fa4wzXtcURNXUaRLakjSNSDx7fUiQ56WSPKLT6CyNspdduGX8MrNuOhtROyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0ZL8ssr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso911391a12.0;
        Thu, 10 Oct 2024 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728585599; x=1729190399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt0d7PTWUJpwYF67FaqTOwRZSMHKQVroP6ADdcxk0tk=;
        b=P0ZL8ssr3jRAvNxlUBtUo3448eaWMR3wWtRQfKOwfgaPRx61G33l/s9HGWQvVCo0V0
         M5fz2IOeal/lTU7Pc7pfH8ZZqm5/2wbQ6z5pS+tc05RWM6NF043Hnxv1WYmHAB+PMmog
         VHvckfLWTvg3i0xOj0+sQTSpjKuzhdXTWSbCMDDE1ojYA63C5mqa6rNkuu9CmwKa9ivh
         fM2/MKuqtVwhzDgon10TcXkdiI/j+m2MbZPZ/R1Av9Y8mi4vbPUL0QbZkbytx6KwANSn
         EIl3owY5avwrOjUD63neFc0ZHNBvefittlEkd3ixFREisK0kIZetJYD9M6ATLZZ+E/wa
         T9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585599; x=1729190399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt0d7PTWUJpwYF67FaqTOwRZSMHKQVroP6ADdcxk0tk=;
        b=kDJufvg0cVsD+pd/6b1EK+lyUsrKyckTICebDYIEgbMhF0lPJB20LMO0yAs+x11U7H
         E+cSuUXktVkG81I6ATe9D5714OwSNE4nuTYpiceYbKB2J0ADAkP8DuEEdrMzgZEaTgnJ
         cVuzcCu+mxs9mK5CznCGYyol5SvJaZbioNQEizoDaWzMjgBcbrVRe1ne1vIDhkuhGmNq
         ivg/qrgddr9iO/7iMXncfEUigTOv1+atOEWRphW1HmGDOciYxobhxx9BklxM/2Lg4MIN
         4Pzou2DQ+c9SZtm5BOYddwCIrpQ/7i0PYVZb6lWBtAayTAnaoebjoN1WDWM8v8WKjyju
         qOpw==
X-Forwarded-Encrypted: i=1; AJvYcCUXqpTGiBf9t1MD7DEbhS6cKHMoEUq9E+cnoNjzwe12fkNk/uBUzJXD4tuCJ8TRhZjwhhR50QtOZmdLd2tUq7093BYu3Q==@vger.kernel.org, AJvYcCWg4iFgwkB0TYpPaQcEDA34ohzgkDQvfhxmTxa7yP9LvJCyqfo5qsv69qJomIONIxEnyVZMlXQtEynnB7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFfFhcXyStefzDb15lAhUNGVP1QrFZ/nE/PE2jFSneFq2ktjQ
	l7zRqnkDBBwtFQmnnv39DyF83PFyAa/qMgk+LPE49xOQHmFd/Z3L
X-Google-Smtp-Source: AGHT+IH68yKbuVbBykHvA5QRrX99U7UIh7JlELPRwWGopc9OZpqMcdOZLjwzgB7xwIE7KEFGDm9iIg==
X-Received: by 2002:a17:90a:d90f:b0:2e0:b5c8:9ca2 with SMTP id 98e67ed59e1d1-2e2f0a971bamr148279a91.9.1728585598626;
        Thu, 10 Oct 2024 11:39:58 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm681846a91.49.2024.10.10.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:39:58 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	kuurtb@gmail.com,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
Date: Thu, 10 Oct 2024 15:39:53 -0300
Message-ID: <20241010183953.13231-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <b4746132-2282-3cb4-64f5-bc83afbcafae@linux.intel.com>
References: <b4746132-2282-3cb4-64f5-bc83afbcafae@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you! I noticed the kernel thanks to the kernel robot too. I will
be sure to add them in v4.

Kurt


