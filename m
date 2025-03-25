Return-Path: <linux-kernel+bounces-576127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA4A70B49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D6D17AF10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C07265CD4;
	Tue, 25 Mar 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bS3dmUHh"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA51F03E6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933579; cv=none; b=T4HbMzYiqaBVXVQrF6uVZRsW8UjlUk0LYkedD5TwAsXkTNwnlpuTrts5qBndwC8rULm0iRNEXX7w05SX/DpHdCgnnIJdL4eVaYGUBrhCgiJB786j0AroSnGQ2znXlNJEu1LEsWdDoXwbWKZ3kDuue04pcGF46OXt7rZ3NNg6mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933579; c=relaxed/simple;
	bh=ok5NgD4a2qRa6ue0cclZ7eNVJ/Sw9fxGoOIpf9865gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw8W3rWBt+Ep24Vhhg8X9eAUyBSWO+m32iVn86MvB72C0WS+/w33oDbmyAvl6uNR8EgKhZKteUCeaMyFNhNi6H6w2YnbLWOZKb1OKghondiMc88/qufdwGm34itL7GgRPLdp3u0DjtUEtvj0UjLEYq+n2dcGPXO/3qCI50aypLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bS3dmUHh; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e63c3a53a4cso4451959276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742933577; x=1743538377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTOr9pYzPi2i26nHAmvmTE63STw7ueFb8JHzYoT0ydw=;
        b=bS3dmUHhHH9nO6UEluFtW8HuQt2jHQ5uUyHptYMYLwSOpj2CuLFBwiyZ991twTRRD4
         1bEcV0ZLgxMOG2dM1MkSShlInKexpGQ+3Y0/jx0Gh+dk82qZt6RhrV0VYikbu7KsU+ma
         1raMyzv1V9I+acXzOItxKJ9XXPMrvdUSeus1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933577; x=1743538377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTOr9pYzPi2i26nHAmvmTE63STw7ueFb8JHzYoT0ydw=;
        b=bg4cuJjymmCCFL11gviJmYf5NsMF0Nf+IhUSA5uVanJFKHBPYsjDe2V0bSFRPTZqsc
         hkMhA30BoFx+RuVA5oAk0hEoj5KrsuH12gX9pDou/sj19WKctxSPlN2il8lp+H/5cvjM
         HFgjLphr3h/EYv61gj9EEw6epAJLGJTlW/gbnqlO0HQ7bPj+ipSaFpTkNuKN/dOwrhoA
         EZaIvM7GGwuygDpd+GdhbRgZB0ykFqEehrVhTA6Ecyr/5h9W1LTRj6m4CK1oKfoVyzA3
         5Oh4xLIOop+9Buou9KCNWhngrCiX1NFLn0Nl1h77axeTh5uW+F8KTTNf4SYhLiI4a999
         JNWw==
X-Forwarded-Encrypted: i=1; AJvYcCURfLtcmktPRUbKsZy08I7I6w31Q8Lo6HqYzCJKomXDLSi+ZDHliU+wqSEdzhsZMUwIIVGY7bub0zzls0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfk0sky4s1DXLla3UFE2ZcgcYdpTfPPSoPvP4iopTVeAHR480P
	Cfjff3OH15jzMy87nfJaYDZSQG5gLf5yiuCyWc36YqP9VixxRQ1IaUfPGJi8e646Jb/fmWsS67V
	7qP8H6D11+QBVIvS8fR2Ex5nPRSYE+7TEhvW4pG49EXsU0NbKPe7Biw==
X-Gm-Gg: ASbGncv64VLhHIQ/pSoQTTx3x0LmGTG6vbxFm3Ot7XGosSBxCYFNtchZ9QxzpDvzwcD
	Vowxz8PYrDJZ6WwGjb2R+pc7ArqYOYrwFKeEoH+9Il0Skq/MY+PTDXFiVRAFl8Rh5B0Rx/S+3Td
	QmT41D6WTWaRsjsASuSBodaGZxthdKNepORuMs0b6HwzrCLoWae/UcevzEHuY=
X-Google-Smtp-Source: AGHT+IHshVRxFVSRgmqNOPKSsYowahAI37eYtNiXXANKyrruJ3NhdMG0ruC6NnKn7RBoC8thTuxakfabVjdrFAm4fME=
X-Received: by 2002:a05:6902:2385:b0:e60:9821:32 with SMTP id
 3f1490d57ef6-e66a4d972acmr23048136276.20.1742933576648; Tue, 25 Mar 2025
 13:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
In-Reply-To: <20250325195322.3243734-1-catalin.marinas@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:12:45 -0700
X-Gm-Features: AQ5f1JroGLoPpd3BNG2lfW60X7dg8N_A3CClyCmOuMjw7azzcTshfNG8StJqxrQ
Message-ID: <CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:53=E2=80=AFPM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Please pull the arm64 updates for 6.15-rc1 below.

This was in my spam folder. The reason is that your email
configuration is wrong, and lacks the proper DKIM signature.

You have

    From: Catalin Marinas <catalin.marinas@arm.com>

but it doesn't actually have the DKIM signature from arm.com...

It looks like you sent it through the kernel.org smtp server using
git-send-email, but it doesn't have the kernel.org DKIM either (but it
may be that kernel.org only signs things that say "From:
xyzzy@kernel.org").

             Linus

