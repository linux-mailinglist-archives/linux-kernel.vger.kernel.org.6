Return-Path: <linux-kernel+bounces-576364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9279A70E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE33B680E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E0199BC;
	Wed, 26 Mar 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="awmjF3V2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2013C1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742950114; cv=none; b=evKY/CpJ7NKbyzkFnuRf0I41SO0Ga0IL9XrFnt2I8AO4+hELbhIXihLG8zvtJFoAESja0QePPvHyq6vVzeNlIJwrvtQEW7NA0Znb2wVidqqjwvSwWgTLd4NYCs435eZhtCmXNJzU3MriIr0X3vflMLDh44ULcFw4RY4XRwa0cRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742950114; c=relaxed/simple;
	bh=9fKBNtR6pLHRVoR58Vx9kVUypQh1EQZGDFoGJuNxsWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKf6VEQdTJpuOrmn340mint2W7q686oWcTswQHG3calr8rqlz/IYpBtIf3u8frtUw5/Er51+c+m1Y1ZcVg6Uts9ULDLyphvESARRgJRBz1bnNtSheOm6DG3V/vMu6uq6c1AiJIIBoSu0ANSzGoZ/VwwupdpFa8uqM08AHGBK/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=awmjF3V2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1250346766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742950110; x=1743554910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5j2ozUbV11p9cWhpwY3zzyLx6ZVzJzfckNa6v5g9gI=;
        b=awmjF3V208+QYvDapPgnF6TPi9lWmndP8gqNzOl+v/EbkymCPvuf1NfEPnNUc4dduK
         lvpsXKZhJ6qA9R3k2IeaNFOBZZPRPR8wwokdipW2gkDk6+tokdXcrvHdTeu24r7/F6do
         b4aoDzLECQqSx71WXUMd+dDxc2Uyr4L+2aW7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742950110; x=1743554910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5j2ozUbV11p9cWhpwY3zzyLx6ZVzJzfckNa6v5g9gI=;
        b=Lt4zIniBOW29gQghjIrrvd74DiFbeHwHKvIu5R0q4TZDFu4se8OjTmmj+0A8NWnGn3
         HQQxyxDBfd68apPzcZr4IMj7x/3/g1Q6jMFBVgH0lLw3Oc9Q64GYIQXfLGT+K1JG7ZLn
         3ZDEa2nlLm31ipVb0s5lxiFOg1wxxBmCjQHE763ZSGpRsmFJJMhULBOXgrxXL/bQhhHG
         A2FzJjjKc1xSSPdWDwtZxvUfoOMmA5NnaiWzHpGCMUxgkwBezVI4wxIL/TRIAmi6InH5
         u3eXZY260/w7BdaUhJAepYLoO3+5qSDnaLd1RWmGKLErd4i0rDpZvO2lwDtW70xGgWKm
         k3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUgfuKhh1M/7vks38fEoWvq0kgFsAwFJsBQlIWNZz4gh8Y6QsKND6m4Ss0rGOewag/U9bZSWdQRxrYzgl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jrRW1x1UtvIPsz4B1dE62JjyOeYIpw0oug2WIE9QskOcN9qt
	QK8E/rh0byGgOaPRzj+6BX58Vyly/o25ebhjNHOglqmc0bBIVq8yr3UjEXLvwGPJNCeJ2dk+477
	z+kU5UQ==
X-Gm-Gg: ASbGncv9kMFO+Sk+JSXOjqTlWr+WKRVkkoWCEhLdiObYeMrOy0gp8/UU6Xs1JMgayIw
	s5Gj2aTL0Wghd1REoL3wn8RBDBOvJ2vIxfNqopVTLQ7yeKbEkUnrvLILa84IaV5rOdkVQe9wCkP
	LCRg5mA8qTIDZFp+uT7QGcN4UIjoqoXyKdMK61nt3SIhyOHU5yJB3bR+SN+XweLa97cuzKZ21t2
	SOCgGKs68xaKIHUSak0pu/ZtqUyl9IUcmtedN/0O6TwBCB4RuPMlrM4Beatrf73ApF+kSQk5wJC
	M7iBpeIDh5qQ2g0IXV6UKBPakwm4rkw7Qn42vp4sLadNynZ2nLIJ5xiGprKMYspuVNbt+CL6lrw
	4PKqHC+cRidu1+USoUZA=
X-Google-Smtp-Source: AGHT+IF0F02VGY/La4glvJKuAOBVklGdANTIAYBYYGRnejAoiBABbgN5F/Or44Ei12gfAPw65aoPvg==
X-Received: by 2002:a17:906:4fce:b0:ac3:d54:d825 with SMTP id a640c23a62f3a-ac3f25489a4mr1864810766b.56.1742950109963;
        Tue, 25 Mar 2025 17:48:29 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50b9sm951819166b.55.2025.03.25.17.48.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 17:48:28 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso1134490166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:48:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVFxGj08UJSjyG5xlLwEx4OjwXDc3YhUDltKpeaOk8MjfKU9+/cuAqveFUeyRgc4QTd2m9SDChA+Lk0fY=@vger.kernel.org
X-Received: by 2002:a17:907:d7c8:b0:ac4:2ad:44d9 with SMTP id
 a640c23a62f3a-ac402ad46bfmr1749200166b.24.1742950108550; Tue, 25 Mar 2025
 17:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
 <CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com> <Z-NHugcLdLqkEHFR@arm.com>
In-Reply-To: <Z-NHugcLdLqkEHFR@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 17:48:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
X-Gm-Features: AQ5f1JpHt1sfWI_grtQMmIWwYdef1dz8TrRcHr4XeG0IwjTtwajjR9Z5n6vqPg0
Message-ID: <CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 17:18, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hmm, I thought that setting "Return-Path: cmarinas@kernel.org" would be
> enough.

No, DKIM is designed to make forging emails hard, and that very much
means that it checks the "from" address, not some random header that
humans never look at.

> This header left my machine but seems to have disappeared in the
> lore archive. Not sure how much difference it would have made, IIUC
> that's more for SPF than DKIM.

I do see the

   Return-Path: <cmarinas@kernel.org>

but no, that shouldn't make any difference at all, because that's not
what dkim matches.

The spf is fine, but honestly, spf on its own is kind of useless.

> If the envelope sender doesn't work, I may have to switch to using
> cmarinas@kernel.org, at least for pull requests.

That's fine, and is probably the easiest thing to do.

            Linus

