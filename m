Return-Path: <linux-kernel+bounces-208936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7C902AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362D81C20EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F240150992;
	Mon, 10 Jun 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ub3JZLD/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0914F9E0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055888; cv=none; b=aa0vlyQCryunAzGQS+eMLdH5YxvxUM2m4KtCPH5hre67SikIMY+RYMI+5FlTE8lTfDebTlmxhqTCowhdhZL4qCvDkuKLkggHeZ7wgbbuZAINOik0SjrYywbQR6UK1EyqNWIcQptxgOA1Hr14KHiwAccMODLO/VlYw5p2xzBkz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055888; c=relaxed/simple;
	bh=S19qrahCzQmZyusHY/aExVOH1PanLUXW6R4szF3uoGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3fwSBvlIRl4jFmF7NHWijlGizkmc6/Xq9WWQ87Fvp7JK0u8U4AJlsJ/TNp/YIIolWP0ESTToLnspM+8H9MbixjIbp455ZKy5c3MdG1sVnATEEocYoqh+2yzkMDCPog+VD15Oq5LxyuH9LSK1+atfJ0/IPnvXJJ+92OOmdL388Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ub3JZLD/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7046211e455so1183462b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718055887; x=1718660687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S19qrahCzQmZyusHY/aExVOH1PanLUXW6R4szF3uoGY=;
        b=Ub3JZLD/FUOSOoLkPj48KNs7PWIfhVYohujQUMSJHUtarRUbmBOnecSCo7VCRGBced
         TJPCSrsQSxkPAhn3nveuZPw5Zy4B/grQ3yrOQ8X3Ois3umQ7ZqoLLqvlVJnZ+TCV97yy
         B9WJBc/xQRTXIBQrCHrtaPxxBQbnNgaf5CTIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718055887; x=1718660687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S19qrahCzQmZyusHY/aExVOH1PanLUXW6R4szF3uoGY=;
        b=qq7cIT3WNbGGmWHDCfSzkT34kayZA3y0VjkUCKTN7aNpyEM8QeW0QlJmrA/50WYduX
         Df29xnhpm/SYYI4xriCkXvOxUpo8Lu4hmFnf/4sGfGiA4MFSF6xR1vCbsbDEaFQSc/Uc
         9XRwSCuJ+mRA/H9GfsvwZU5wP/Ys3rK+2i2tBr3Soyq14tCuJImlJ1WGkmpJtyPiHTgF
         2E7TagMRA0Y+CGt8ztdYqDKjb/fysrxb47ZDNmAjso+djGlaGYB6FltASoptC2BUhCas
         0kWTEOuMtAH6j7M2YoMuzZxpu/JNcdX7ed1GV+orv07f/dJvUO0WeTyWzWRf6TZpB7ob
         0aiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvlJFiyiV2hhGg2xeXE23XqzF9k4tR4U0rjmE4euUtLBFUqENLnyYj8tz1JRVREfR5z8VasW9ro3ztDaqQAmAZ4feVAz8SwQy67Ilb
X-Gm-Message-State: AOJu0YyXB230ulB1PDQAufmPzwwWZKYhcek66wQ5UJdlnrrpDi9xUqDk
	4CEKXsrIKjY8uqg7x03LMugeMrG8YFlkCL8rVtHieiBC8uurN72ODhBjqJdazw==
X-Google-Smtp-Source: AGHT+IGXhe1WLILOy3HZz0s8IPAxJeb1xdJl5Gm9Cx3EI5jcAi3StB9ke/iJU9ZN9GCmFP6S0zifpg==
X-Received: by 2002:a05:6a20:734d:b0:1b7:2fa7:4168 with SMTP id adf61e73a8af0-1b72fa74422mr4433334637.18.1718055886987;
        Mon, 10 Jun 2024 14:44:46 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7043137e78esm3459427b3a.133.2024.06.10.14.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 14:44:46 -0700 (PDT)
From: jeffxu@chromium.org
To: aruna.ramakrishna@oracle.com
Cc: dave.hansen@linux.intel.com,
	keith.lucas@oracle.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	andrew.brownsword@oracle.com,
	matthias.neugschwandtner@oracle.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jannh@google.com,
	keescook@chromium.org,
	sroettger@google.com,
	jorgelo@chromium.org,
	rick.p.edgecombe@intel.com
Subject: Re [PATCH v5 4/5] x86/pkeys: Restore altstack before sigcontext
Date: Mon, 10 Jun 2024 21:44:46 +0000
Message-ID: <20240610214446.3380115-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240606224035.3238985-5-aruna.ramakrishna@oracle.com>
References: <20240606224035.3238985-5-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Can we we move this patch to the first of the series? this can be an
independent patch, the problem not only affect PKRU, but also other
scenarios, as Rick pointed out in [1]

[1] https://lore.kernel.org/lkml/d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com/

-Jeff

