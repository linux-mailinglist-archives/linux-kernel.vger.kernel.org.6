Return-Path: <linux-kernel+bounces-375238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C39A938C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2896CB220FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202EB1FEFDD;
	Mon, 21 Oct 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dXGaADtx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8311E04AB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551076; cv=none; b=l0H3lBHjDcbNAPQAWXkyQ0p5tEKKoHXLiSYYoeOx8mwE0VCmGAigAXd1qwHHL3DWUwBRmHtvfuv9lrdP3kI2zBk8vOe4Hj6R+GbuF4gYE5YPf307tv1/zQ1/SzM39UsZwWvY21z/TLRsBzW+hZyMAc3vKk/v4EwWY7D1aLWElKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551076; c=relaxed/simple;
	bh=lh+egOwPWiT6rlsPd8Qz6EzFrLWfAdtma57sGF21Yeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCMp9zMB7CbHuxiXZwxyIRd3mZzrVexi3Fk9VOlM6cztxTWoF8AP3vPD75llzimBpEikS5HkpmSuF7lrWMU2d2i1lTTR2KoLq6HVdoN+BctED6CY+ifm1qU4wm9RozO/8W2umLfByDPxxmx3Bc0s9quqwJLl54nql2GORJoSBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dXGaADtx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso5369833a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729551073; x=1730155873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AG8PzQqdiYQlkH144tEImcdVURTnmabmXi7XXqqoOAk=;
        b=dXGaADtxFFq1qsRR1tX3Q6ILVX7eeaBl35stlmE8FI6HR73EKiotPYr133wsWQSFxy
         sAaMEDbNi+PF2hVT19gme0iA80NtWZpf1NSn35Pctr0ARZ+OUPBMgeDq1245YnObFp8c
         tpfDLEXeF1H/YvsNE9SDTeRrNfrEPHMvFY2b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551073; x=1730155873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG8PzQqdiYQlkH144tEImcdVURTnmabmXi7XXqqoOAk=;
        b=B5IXrau3NakN/cfWPbIjwALcNIBgfHT0WDcJdqifnKCTLFQNBHYhqXG5cwCDkHjLIs
         XXaqaaqvgcI9iV0SEQTfPX9VQLZtoC+6uxhHmGPFEC8egGiQTo8YHsv7Hb7OMDvHawfC
         vNQIGaK5G8/WVcveOR+oQNXz+4qaJZIPxmu3AB3QH5bTZVszjej2yCoZ/LBFNrBENKPT
         r3pdaF5a+6G1TdPoilm6r5kDaEwXz7xH7/1PvH8jZvHaAufyFMNI5nsbn94/5UPk6Qf3
         POZ8UqtUgKQuIkdyFnqCnOT8gfYOi3kdkLiMp2s6ctwzu9MgdIp2Vy00iewSjYsADT2i
         lb+A==
X-Forwarded-Encrypted: i=1; AJvYcCWTKf/0AeymZHvhP+s/AUXpmQ4sYGEHSvk8qd2flG65P9YlzNaZAowFvfMPCCfpQuN/hfGoiH/bgDw7lwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnA8Na1kVC+QRvYJt/AwwVHNhhN/SbJMRFcbH5R1zaMPq2N6L4
	rp7JzaNQ8j0YlPsMvQdK15P6R/vf8BcS7T7hFK0RaBJeoRUN2AZwCyJajH2M9JmSNWi0yb6C4B1
	XAfhz5A==
X-Google-Smtp-Source: AGHT+IEpJlz86Epi397iPSR1PxuVLFN3KE5sSA8uvu7EqRhiuMM81uOQKHy/SDTJBllUfI1UqxJ+Mg==
X-Received: by 2002:a17:907:9414:b0:a99:f183:ea8a with SMTP id a640c23a62f3a-a9aa892cc5bmr145649066b.28.1729551072971;
        Mon, 21 Oct 2024 15:51:12 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6ee6sm260913766b.4.2024.10.21.15.51.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:51:11 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0c40849cso778662466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZMsCy8Po1RtOu9IMSmJjBuRK3QlkewxG1ItaeYWfmKteJnuDWLO0eXTnUsij8IYVXXh/goB3u5T6nsvM=@vger.kernel.org
X-Received: by 2002:a17:906:7955:b0:a9a:222f:45bb with SMTP id
 a640c23a62f3a-a9aa892dba8mr141312566b.35.1729551070822; Mon, 21 Oct 2024
 15:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-kvm-build-break-v1-1-625ea60ed7df@kernel.org>
In-Reply-To: <20241021-kvm-build-break-v1-1-625ea60ed7df@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 15:50:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5OoS9v3h7YOPf2rMFWGfHQUgNrFRJ3NVxJLZDn3qnBQ@mail.gmail.com>
Message-ID: <CAHk-=wi5OoS9v3h7YOPf2rMFWGfHQUgNrFRJ3NVxJLZDn3qnBQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix build on on non-x86 architectures
To: Mark Brown <broonie@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 15:16, Mark Brown <broonie@kernel.org> wrote:
>
> Fix this by making the addition of this x86 specific command line flag
> conditional on building for x86.

Applied directly, just to have this silly thing done with.

Thanks,

                Linus

