Return-Path: <linux-kernel+bounces-515192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3AA36183
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E06A1891205
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254532673A8;
	Fri, 14 Feb 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NknB5qQ2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FC266F12
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546465; cv=none; b=W7XDUS4nwYii8djxoQovk7cvmH0QxdE5Ay2yGaMNoKYnPUTxYzy89fA+iBR9TVltjmrWWSj1teu/p147+ZX7l0mxM3hW4PZYSGLuiLxolH+9qGQKnpN8Urq+bAkMX3aCPEBtLEPOoREzINABgNrKrSxP+ibdHpGX1z4YnMXTbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546465; c=relaxed/simple;
	bh=k2ZjGztjrBRL8MdtA9H8+Fs2+gktoXAfXfoKF3hMIIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fgBXWLuot+c52Eavr0D9/+lEPMPWEDCtfZu2U+UmOFhEjprDw1A8iI+d31AlsHgjnzT1fAKGirT5XC4B2stvrR+hrJ3EzXTzf7/1ovHVtYsiwPfFfpaNjH2iGItMUlBLz+EXgKraKVNASbGaTSHRW1Yb0zM3AC/I1fwsYySJAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NknB5qQ2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22101351b1dso2750895ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739546463; x=1740151263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06aFn+/vyp59RhN2ivO/weW44nHTsSDlvI5gbGhiN/w=;
        b=NknB5qQ2qYXcs8/M/mV4WHmY5oHtoC4iwdl04bwxNcZpcEaZze6Sq4Ssr3ivK/0cme
         iTFBK/L8HNYFbuuTri+cThaXaJQ/UYYvjSKk1BnG0IMxjxCcuqyScM0yRg9MUqv5r7EV
         cA3AKxUn/Ki4+gJjh9DXVX3P3XkpxaWZHsJNwIqb51HJ0RhlWlShwEimyQ0u1JdzyCHB
         Dl4FFDTFhFT6e/AGBfpqgBTLScHvH2pQbOX+T/aCrXnjMnM0/33mloi4kRsNFu5F0XVL
         seNIH192gryr47Hg1zyhN4xW4eK4vZjRbujOXIaTMzJhrjuHXncSXGiiXyM9yrLWoC2E
         qR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546463; x=1740151263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06aFn+/vyp59RhN2ivO/weW44nHTsSDlvI5gbGhiN/w=;
        b=jyQKPIwl+ezY7SIYMKHe7/02+sNcm6XQItMYTZ1kqqCXl199TR/mQREzjMvA9aXzJN
         3YjNnd/IvDBVvhNWscPCBD2GwQo4ey8eYEdAM4xVJ1yjWfIqqmvS+2HsSJOKvOmdCH4l
         K4oJ3C87hxLdd4wMFxh0IEuj2fYgFBPrnkcEG2XdDbZ8vSiI8LW+QioLg+989qs2BMTG
         YPvyK2f7fSfrb3C+ajMN2IckpfAKR+GtoHsUtsXuG/FWwW27A08MSlfKhns4BLzd+M/F
         QM1Ju2l/WBEYghN+ztsxUpaDOxSZ+wVuxvXQHP234IVez1OvZ4yW76kc/Ei7IGNe14+H
         hDLg==
X-Forwarded-Encrypted: i=1; AJvYcCUNSmBq0IGGYqdiXpxP65U6gu1x5B9O5/qoF86WqcnS42eAb2fNYUE3kkl/weIAszcnZtiRQp+oJZhgp8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9pcUQattbx1EapkycjgovgamwlBnBy154mNweuS2/AOsFR7P
	Bg0xXhy3nuhqGiaCt3oC03q2mpQp67Qg1Gja7DCJNXZsSuDWgWZt+n0YLH/leJNJ9CbctEXDuEU
	X+g==
X-Google-Smtp-Source: AGHT+IEIuKmLpEOOIeM3cBT0i93rzCtLMoR++wEsyi4WcivIxsm6iGeEqERqPFc5PaEUHbMcfjuAWmNt/OA=
X-Received: from pgjl8.prod.google.com ([2002:a63:da48:0:b0:ad5:4679:1815])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b04:b0:1ee:89e6:30f5
 with SMTP id adf61e73a8af0-1ee89e6322dmr1845786637.16.1739546463162; Fri, 14
 Feb 2025 07:21:03 -0800 (PST)
Date: Fri, 14 Feb 2025 07:21:01 -0800
In-Reply-To: <20250214130201.15903-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214130201.15903-1-colin.i.king@gmail.com>
Message-ID: <Z69fXYWn06CpPK4u@google.com>
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake "Unabled" -> "Unable"
From: Sean Christopherson <seanjc@google.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 14, 2025, Colin Ian King wrote:
> There is a spelling mistake in a TEST_FAIL message. Fix it.

Gah, as usual, your spell checker is superior to mine.  Squashed the fix with
offending commit.

Thanks!

