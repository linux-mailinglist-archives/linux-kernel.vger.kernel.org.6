Return-Path: <linux-kernel+bounces-249468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A792EC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7981C21B94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1916C856;
	Thu, 11 Jul 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAAlILJ/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404416C86C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713494; cv=none; b=Yqo8q9HXhfwYHiPe4+Z3wnGi9PRW4om1V+lfOqI107xw0l1FlM6PkyN6LHHnOzrImvdjNJQXoD73vuKyVx9hRP6I9OP8r/tpJ36ulcYF/aQgLqSn51hVIUBtkcWImo29LLVk0GmpGVUFDIs1DXY/dUuBhz0Tf24I8EHHTqy+Cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713494; c=relaxed/simple;
	bh=lZ57MzrlCzRCw5y4d12vHyfxZcRH9OCyRy8OqmzQvRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJgitxJxN8foQAfpBaOIh7dyEXNlK1qstfj7VpArhy72q3q2p+1ZldNgsxTRrBXcVNj3YTK2+Gln3FfPl3ksuobfLbVuFtFoX3OuB82FU/OLawrQ3hrV2BmDuJZn893umi3wBw3mLPu5AjnuZk9TITONb5bnH+dB4TUw9lFI5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAAlILJ/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ec0ad4fa4so3371e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720713491; x=1721318291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ57MzrlCzRCw5y4d12vHyfxZcRH9OCyRy8OqmzQvRw=;
        b=zAAlILJ/KTtx7c6CyhfxfIWf/9ce96dqTTXiXGzDXjfUpe8xpwaT6PgTm9wCD1r9Po
         +HMtZMVHTJGY6ATiPxYgGYZe3MQySo40znm2k6Gn/qt3r38sAS33d3rV5n8TQo4rdSxl
         GyX+DEkk8BB8ozsYMpO4NFNaHItyqN31z4ywW8g1IfhqzGsoh7tFbxQfJvbQBi4vTl5v
         M2/3s0Rlx/pQ7KulzhKM63P4qqb47Mw/55XhEzF8+enoB+NE9Ahjw7ZNvaUdspcki3l+
         wwFPtIESgcAeSErdcllTfxIoY22B4jYgmMfQhw6murHq5cHWJeLh+dUAqEk0a4V9Opwx
         b9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713491; x=1721318291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ57MzrlCzRCw5y4d12vHyfxZcRH9OCyRy8OqmzQvRw=;
        b=dvNuGbn72p2momo/Oy1mZrQ6Qe31gTM5EJQ8crUx9tJaKA74EGsk9W5QrhsnU9CRG2
         S4HVxgTTtVqrdKSbEoqmvRgBSU/caLzZIKLN0PHEuDRvZiD3rke2omIZonYq7k96uvTk
         Bg8K39ggodp7vSNVAk+YJRWMMBxyFnWpIp28SMBIj34qYz5DLAaCVqsLlvNyNkT2+jc8
         j3Vpa5pjfvncSt4g2EK8bCI95erF/Gz2568nis0kC0rMMv3cfEEkA3VL4pjQvjJackHS
         qgMQs2Pb/as5pQIrZKBrjR7U+fMsQmmzOR4Yf+uFyCLJtxgcpevWLziMupl0rCcAktse
         qkIA==
X-Forwarded-Encrypted: i=1; AJvYcCX9eEaLZ7FW9Z+hIhM4o21zyXmmTKOkfQ+vaf8KFYjQqZ4fBYxOZ5POQMIy4vrlo3xwNI8m/BiMS1/XUvajEv0MVOLsYaHf5gyKMQ6S
X-Gm-Message-State: AOJu0YytrV0gfqZewDJ+lHC+asL79m++dyHGto+9GgPh0yn9inzxUia4
	g+qSnQjySZYga0PZkZi2Kkl6WBAXqsyO4LMVM1j13waJTVUZzfAYBSn8hLKB38T7VZyvnbWCzOu
	SxPaxEt97vIB8L/jlPNDxK5BiihBh7YUPOkfp
X-Google-Smtp-Source: AGHT+IHQseqdHefTsVPVRXUMWIpckUFaJt5NZYFbaaDXHkwiXRWpcE/Zv8cBwZBUtzEWxm+xIla85YyZTZg5GUR0dpg=
X-Received: by 2002:a05:6512:3f0d:b0:52e:934c:1cc0 with SMTP id
 2adb3069b0e04-52ec5b0213cmr130645e87.7.1720713490965; Thu, 11 Jul 2024
 08:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-6-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-6-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:57:59 -0600
Message-ID: <CAMkAt6rQdGAjW3=+2hmZ8RXzdDH2NsPT=eqAg=kaJ_Cz0qbQWA@mail.gmail.com>
Subject: Re: [RFC 5/5] selftests: KVM: SEV-SNP test for KVM_SEV_INIT2
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:06=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> Add SEV-SNP VM type to exercise the KVM_SEV_INIT2 call.
>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

Tested-by: Peter Gonda <pgonda@google.com>

