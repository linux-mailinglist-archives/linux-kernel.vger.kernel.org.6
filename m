Return-Path: <linux-kernel+bounces-511632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB8A32D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB5163687
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6D25A331;
	Wed, 12 Feb 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHyFBImX"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6112135A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381355; cv=none; b=AA846vpsUN6zUw7QqRP1OI7V+TCBQMeapX13ogxe+P/kpwHOm/lXdwaF6yN8V3SDZI9EfJm4Shl0v9LXrCNH5ADDLtFpQYdC5XM+SCqYL+pM39Tv5tPN3lUtjwIAw5sbbpImEh0/wwrjV2SvLgZ/kIpbLO1BLtKjXlbUi6g/zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381355; c=relaxed/simple;
	bh=v1E0baCYwvPTm6W2l7mhYSDoo8BYoAb0Zh7kaADVDQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkssKUxa5j6siNd0rCnEbmeSj9GQfbV/kMlrC1sVCQq3t5M45w8oathlsa2yn6pOTqjJjU5MXnJRJ3iQcN4fBhATciHE78w487cOZMT5sAFnuM0p4PKKP7LqM+6bszFgOftGUZjrlCgWf+XuiGzg4g/mA1LI5mxj0uRu1F5ka9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHyFBImX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd049b5428so183846d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739381353; x=1739986153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gquHr0eT2+B6bx9x04CQUMoJUVGXo0TIanyPjb2fHkM=;
        b=GHyFBImXoKYpaJLH0jS9V0i7iYzkC4DxH3N2q3YKZsGeOJdBrxiossETK46ubAeQaN
         oTke4evi216ERhawBRt+/jbbHZiLccFQ6omBRA5owDm6I8F7PXkTpLm0j3LFsEEorT8T
         elgNAEgal5wMGkVZhOlRYOfKTVNYXdix8rUCBvmAn1cdBJ9HoyVDmdUkFw6XNMBxiwCF
         nmM5vu8qzI8W2Vary8/FIbRqGN17dh4RE3aFGDfWW9Ef5/calZz62v4/FXgDF4z4K3Dz
         lgjKbtr4QDe95qs1nD8eovSNqv5B8ZvtDpZ1WxyWkiAqdv+JDpvC4vq/DTzQfvkYmxcI
         3BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381353; x=1739986153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gquHr0eT2+B6bx9x04CQUMoJUVGXo0TIanyPjb2fHkM=;
        b=p4axdSf8W9A4ZnQqlUe64i2J9L92qVSorLG2Y2PyMWIuHohw2e/HPwZLpfoOHsl3gR
         vzuvn46pJ8/r8tCfrNmMBLeUVpgY9oCwCDrtm+F4+Xsocd853uCspS53vKS8j0//U1Hx
         KW6YZ+4+ToCr2sp8V3xrmeqw+D4Tl5IIxNbS4vI6rjjBIflE5HWoY5DHklJ+6ABGgrbo
         DzNydBBTtKIRQTGVytk9ITaobRpxrWqGv76yGVPvhNDYkpBGi/wn66khurpmuYk2agBR
         G4/5QbZqhl5GPXCVlIWSPfkMK8LerpSz6mIQ+kFXitub9e+gU5GIuieSBqppqAtRjcjw
         jniQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZT9nZnTo4uO56nHgtSlP76Nfz+ZJiiinB9JSyTDrIPSUEGbmGR9MUjqyKyCwSfz4PxRsPKMSw2HnXig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0R1eSAkOiwansT/VeEKQUFBPaFDtHFW1OWr7RJVgQXojvhDDz
	4bPXLU4QqStAMJqE9ABC0bPR01vhr55yOzjBWRds4vszHgGNMwiUrS7AWlUclCpMNXFWXlmpdqb
	WPSPwUwQLAM1NTo+r7l2Blgh+FcT7/u+P3rhauwDRbwBS0adzqw==
X-Gm-Gg: ASbGnctR3I4akaSXNOcaAmXFfDCvfFMjf0G03CiNmLLHZCvmZbGL34UkTgqQEmpuAxk
	TrFVvvH6Lquo1MKDaNir6vJXE8McoVrOpAiCDPHezXvn9FxJjgkGMhzjPxB1Cn5sAqFIXQ6ueRr
	5/a8FP2FhS5BAiM34U+t2D1u/ZRRU=
X-Google-Smtp-Source: AGHT+IGyUbj2hccuFFHlk1Hhvr5KM33hs3n3t+wSbcCxGyj6DvlsLf+y7cGmeGwq95MetrI7dseIGPBZiiNjexR0q7E=
X-Received: by 2002:a05:6214:19cc:b0:6e1:a51d:e96f with SMTP id
 6a1803df08f44-6e46ed8e6d5mr68013576d6.8.1739381352553; Wed, 12 Feb 2025
 09:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB0421FF8BC82A17CA7A892675A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB0421FF8BC82A17CA7A892675A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 12 Feb 2025 18:28:36 +0100
X-Gm-Features: AWEUYZlUvPCrE_W2ZQDiIkwuwePQ9_OsUYB2xuuCg9zu3mpKV7G1pBpzp4LkW9M
Message-ID: <CAG_fn=Wh-Z12SaBNgXJNqKyfODwxUAYJqyc86hguXn2M2Fv=nA@mail.gmail.com>
Subject: Re: general protection fault in __fib6_drop_pcpu_from [CVE-2024-40905
 Incomplete fix]
To: YAN KANG <kangyan91@outlook.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:27=E2=80=AFAM YAN KANG <kangyan91@outlook.com> wro=
te:
>
> Dear developers and maintainers,
>
> I found a new kernel UAF  bug titiled "general protection fault in __fib6=
_drop_pcpu_from" while using modified syzkaller fuzzing tool. I Itested it =
on the latest Linux upstream version (6.13.0-rc1), and it was able to be tr=
iggered many times .
>
I was running an unmodified syzkaller build today for a different
reason, and came across this bug within 40 minutes of fuzzing.
Just giving you a heads-up for the case you will be evaluating the
fuzzer modifications.

