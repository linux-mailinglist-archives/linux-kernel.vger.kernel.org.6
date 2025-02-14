Return-Path: <linux-kernel+bounces-515583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD4A3667A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA981897235
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A091C84AE;
	Fri, 14 Feb 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RRmXApM1"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9F1C84AF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562621; cv=none; b=BQvRJk2xUyjUJ/KdNOu/PTl/Jof6yfUy7vPIuaYlBPFvD1+vU8ERNIpH77ZOEmfG3NcCjgDksZd1mXNjeeNQXdiWESZp5ZVWQ5FBM5eCQ4EY4FjIS96eCDOYRENKbctxsrbpoJ8PYClu99sQ1+MwEBZ0j7i6hTiejtVhOAiGff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562621; c=relaxed/simple;
	bh=kS+/RPbJQYyV4loDfeQBtye1zVtLY7WDjjNFf5eieKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9T6URYbQM5uaPKbVCUAH76oHNkbTkzcpuN2TPei2ZBhQfyvXHN8WHllyJP1LfBwSa/DOZrVkeDs9IDm9GbIxl8D1xgyJyLJK8L4kZVX33zQrpZVYgmua6X6pejhGn1ry6mevDclczjmU8RdfiugNDUenbWHjbeWsTXEgTQHVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RRmXApM1; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so24770631fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739562617; x=1740167417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS+/RPbJQYyV4loDfeQBtye1zVtLY7WDjjNFf5eieKY=;
        b=RRmXApM1VzEUhNlmKR/wQ4LIJnjDwFW3NbAetG/SMMao+AmamzaFFMPySC5ButQMuj
         VjlsgD2iB1nO3Aev0mn6oWjnRIyDgjn7Bk2D4lNR6RJwH5UOj0YCGdMFFC7Ei5xeyRP1
         hSqB9LRxO7PMdkN0zeXHm17ShTzNF9x9F/soU43OSyzLEyUiNQiwcWyI/BjQU9r41saL
         h6/yCgvZebO5VPWapZgBlTjR6QSWba79Z5/jmTCrNXxaWeyoDl4qa6Sb8i7cEgjicGHp
         a1qY6a+1nENXjSW90tZVBC0LjIA5NHAeOeZRoUYGJulgDls+pnyzmgLIB6/+X5YxPkcW
         nzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562617; x=1740167417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS+/RPbJQYyV4loDfeQBtye1zVtLY7WDjjNFf5eieKY=;
        b=EnQ/8JLVGZO3wbBWYcJMO0/SaJXb8SGv+PgylI1D8uC9dq9Epwu9/5q3mAK1ZfSvbG
         DgSYAPcNgmTboLHj0uW3fVn/G+nwHM9Cud/D54L4Oyc1z1SLrkzndPEmB+aa55f7VuZU
         mXLty3gP5qBfp1SRneXSKCDbY8A52Jghcp9QEMFENbWaItzOeNmBcbeIKMlJvxsxlSE5
         0dv67KoylFSxcnZWfSoeRu+JvoLLBU9QPyS0BJPMtnd6iQ0yz1HEpJGROZH519GbLt3v
         g7LM3QivQBryYtUAtaeX4LejyO5hlGF1a0x95EjWLOiHVyMu3vsDI+mVZ4sz6OXAGYfi
         m0ug==
X-Forwarded-Encrypted: i=1; AJvYcCV/x+1EGYecFH2j69FpqxDyVw6lVQ+x5Yz9O+BtLrkie0h3AZF+uyX8+1LZbyUHtbJxHrjTxcu3O283DcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQx4Jo0h0XPS0m4xKkhmhhXwj+H98VDU1nfxT+iPVyon2mwpE
	tI+YBg6dWTDe6sXuvTeai7ig0FvniK9eYIQGZE1tBfOM4A+Hz7SPFjI/O4Qd3fFwTkGgbgSicVl
	LUapxiF9GwrSWLpW9DSxR7yVW6Rz3K9csFg7Fsg==
X-Gm-Gg: ASbGncvmJb/Qzv3UOWNFmuym4bT09Bf+9cFrtCTAEsrGWs9LH3l7epfyzTPF/mNQ+5L
	vo0UAcbmclUTK0zfG8jiX7424PcJ24XI/T51VfX0KC5+qosx1f4mkH1UV8E0yF3oMGY/5kt3WeE
	KKTTSYbSd8pm7odqscbqYoCjMdGEo=
X-Google-Smtp-Source: AGHT+IGlWjB9v2asjVJFwzrcdKSekLt81bHRgl+1Bt0xg1xeMTTWOeCFD471Hob7Y+mGo6EDLzkfEPEyFyoJEPANwtY=
X-Received: by 2002:a2e:9119:0:b0:308:eb05:9d3e with SMTP id
 38308e7fff4ca-30927ad5405mr2911351fa.23.1739562617279; Fri, 14 Feb 2025
 11:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214152642.90363-1-brgl@bgdev.pl>
In-Reply-To: <20250214152642.90363-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Feb 2025 20:50:06 +0100
X-Gm-Features: AWEUYZkw917luEw1Ce7PiWplpAK5z0ndMU9Sa_ZKL-PQQDyBap1Mce-PhsTSfqo
Message-ID: <CAMRc=MfGDmn-VODwBhqsSTs62+6DqujGdAQPmir+WBjnV7eaFw@mail.gmail.com>
Subject: Re: [GIT PULL] gpio fixes for v6.14-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 4:26=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Linus,
>
> Please pull the following set of GPIO fixes for the next RC. Details are
> in the signed tag. We have fixes to drivers, a new ACPI quirk and two
> fixes to GPIO core.
>
> Bartosz

Linus,

Please don't pull this. I just received a late sparse warning about a
commit in this PR. I will drop it and redo the pull-request tomorrow.

Bartosz

