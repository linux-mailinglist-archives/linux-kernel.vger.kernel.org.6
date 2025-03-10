Return-Path: <linux-kernel+bounces-554638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E392FA59ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D35216E103
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B122FDFF;
	Mon, 10 Mar 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AY+q+Fix"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8B22F17A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623432; cv=none; b=Oiw9kIHrQmGMcoMvt8b8Poi1fLY8SZwRk6dzf+N5I3f5a9qOV5CJcZ0ZMGW+qD2MbuwJBlxh4TQt5EKqUuEdVjtsaHHxLFm7Vv0TSONrYaYOSEa73dEcMztkRCz5T6aoNyRuJb75SLc3yqMJ3YEPFvJtvBL2yrq5LoQaQiavPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623432; c=relaxed/simple;
	bh=E5gkLF4efJbEakqe2LCyGh3dRXBQKFkQyAgDGFFrD/E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dlvs0u/iArDsGaE5DL2VgUFc/m100ipC3GdcA7eUHF/INeHdK0/G4f9QUF4hLoJDJOTVJ5zFnoEUB9ObyoxYw3rEoR1jzmLg325sMcSWSiJWaH2+a4Yfe3PobzYH98FdCziUSN95f/2OjMdwUIxJEUTTlnNpyUQCFfELlDSbIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AY+q+Fix; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2217a4bfcc7so69634945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741623430; x=1742228230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5gkLF4efJbEakqe2LCyGh3dRXBQKFkQyAgDGFFrD/E=;
        b=AY+q+Fixb/TovXaeoNGX4yu2G3DhjbwDs2qV2dHdvU0GZ6/81XD9YQQfkwbTzdV+Hq
         uDe+zEKR5jjRxka1ut4ObLgqPo8gFKj1eKJQPIJNKU7TBhhnYjGXt3zM0zpe1tfP7aWZ
         ppNTtLynMqw0DiIoEZJ1gsUjQVPFvKLTPKt4B4qWkI4H8oxAwTSu9XdFUz7MeQ+EqSNP
         EcOqGiuFaWZ09PatCYsPRvQ1s7iUE1EnZ2aQ8gePwMeN5fGtz86foUQ/2twMJcU3kNLi
         aQFRzTOKIeaFmpUEgRwQkORItGCGYZFlmQpwm1F69SaPBHgrjBw5nrGKjxqe9dR4pRNE
         ejwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623430; x=1742228230;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5gkLF4efJbEakqe2LCyGh3dRXBQKFkQyAgDGFFrD/E=;
        b=Fq3MMjJW01RC9B92HhSaIRYFQtuB4HZsSH/ZeUooQHZFpdEGLSCoqs48mmtGa9rg8i
         W392QDfp1zQdbgh11ohxfBH70qV9XGKFjuzV6M1u7SdudWo9zlUgVT68YyqbBiYuVgjH
         JN6ngS1CjfqPdtCl7O+LNhcsJRceftFgV+gTD5pVWT2GzNmXtbZASVhfACT82Lmb5+z+
         TSRMMLffp8bHRcp4LkTjfIs1ZLrz2vmpeZuOjQnl0/JjuyW5aJew4DwW5lqipobHttsD
         4jIE8pLvexUOcXDokDew+9fk2roqua7N5RNm9LXBgWB0QKTw+P6G7AjNuGq6ESoy2flb
         QZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnCpKoL0IizRsK7FrvOkItEZXquXl87eRNqnue+2t908Dwfl4Qa4GIKvT2L8nbYDKShCPpOFrPua9XM+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2WvUpAXq+TY7qOUwNixcf+0euNjR2km8pyi6B/umzup1HWrm
	ZGFWaxILFUdH9xXXiup4RDKvic1+OIy2yLgQawtE+IthXNpMtTquYx0puhmU98zEe+uL3Kr6G2k
	F2A==
X-Google-Smtp-Source: AGHT+IEvtopbnUmeWsy/nIhJXSJwmRVRXafyvQtfaSeezEXN0bryU3yMD0urwCDwgpBZydAdDQCaU98xn/I=
X-Received: from pfbde10.prod.google.com ([2002:a05:6a00:468a:b0:736:48e7:45b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3994:b0:1f3:32c1:cc5d
 with SMTP id adf61e73a8af0-1f58cb3fe00mr534312637.21.1741623429907; Mon, 10
 Mar 2025 09:17:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Mar 2025 09:16:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310161655.1072731-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.03.12 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In protest of Daylight Savings Time, a.k.a. the worst idea ever, PUCK is
canceled this week.

Paolo and other folks in Europe, would you prefer to cancel PUCK for the rest
of March (until Europe joins the US in DST), or deal with the off-by-one error?

