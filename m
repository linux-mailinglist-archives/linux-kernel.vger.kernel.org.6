Return-Path: <linux-kernel+bounces-559505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D73A5F4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBE73BCEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9B267393;
	Thu, 13 Mar 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="HqRdct24"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B000266B75
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869510; cv=none; b=n0X+2jf3czyHnBL4dPUAKoGYyLySPwmf10U/A6j77UTp55OGFmLkjiFw2AkXT3iz3QaBenWUj1k/1idXnG5aUaV838adHna7zEdCMbLLq6mZDGVkRqeL8h1nDYF+j8skynx8FoW/dhcaBbo4hZU08KsN1xyrw9h6E1VR9jVNnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869510; c=relaxed/simple;
	bh=erWzRxtDS4S1NZ6SEX0W8Mqu6JAwPoiR7LvigQUjCa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jx5imS5NAJhPZIqJxDbrB8LZUeEeLy6/RzygDKi/Uxygi7MCL21bqTKT3zB+TcWAclZYp453f+JE77Ky8yCFyYLenc49vqzovRbgfLzJjfVHX9SNrFdHAnCXFsPrIK60a5zZ8a9CwDtZcCann9arOdwX5hUncU54QT9yAUJsJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=HqRdct24; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso1598839a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1741869508; x=1742474308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erWzRxtDS4S1NZ6SEX0W8Mqu6JAwPoiR7LvigQUjCa0=;
        b=HqRdct24nl7fFG1EtuzCyuSc38eY8f8QBfh0GWv+x3dGoUqP+DPgSV8MqzuLZKiekI
         fUphqPNl4CsNXXXzF8bgOGPs2bSBkN/leQKEvStpDZa2BWhUPcUd1SM5AE2WPTe9j5IU
         9LD8sMKvHsPcEuayxdAvZOL7YZpfuuIXbL8sfwdVf47gjd7J4vjc++AsBV0XnL84VncW
         kuN6585frynZDbnnSilQJk7+Cb0jGJxt6aTAVk/jrZ3xO7Uw4mFWp9IVuwNa9EATln4j
         fYmBhJHZ8ZglRT0iwjG3f4oYqpY5fVK1ibwMIVDDRfcyOXUU+JGkhaWTC1Lcn4Ybgo60
         SY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869508; x=1742474308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erWzRxtDS4S1NZ6SEX0W8Mqu6JAwPoiR7LvigQUjCa0=;
        b=Eua7F+ocuaPwjlxZCdoQL88+lAwfOc+co5R75SEP2TKwxv8h6KnE7HCV+8e+xoYdJF
         QdUEucIbiUuP37tgOMQAakifS4uUF5a3SSG8uI0qcRXmqGuuSJciG8s5nxLqpfuwKcKl
         W6H9LG3kVPi8mbg0L8Qdn1jWW1XvIY4YmsPHc/3B7iPX/wieA7UT7hnWfbSfBSnX+TtR
         CfK/klQXjyhValu1HwKrXzucbdotWoaSiNU5aV7bEyDF90Un2oMiUuKplsmRX3jtzP+A
         lrC3nazw4Bitex+q8Cnzx8O4+oD8A4TjukU7RA2YHxWo79qlYjGjc/rr0pbuN+PjSO0Y
         vo3A==
X-Gm-Message-State: AOJu0Yz2phryZ7movG2QPclEzJV8jh5o7Ig9k+rJIt7JhWoiy4kB+YO6
	nPcVclThPyfuEf0v6xr0ZK/2CBs5lXOPY5olrPd11NIxpV6Vunao2BmlCx4uwYcepunGeUOwAOK
	ZPkSDTnhikyGkOXsfD4baR5kkuul3ibFJUybqQg==
X-Gm-Gg: ASbGncskg1u6aw7wNvtsOtNaaxXgdFCdEo8olQsP+hvkATyOBMgbIoqosDEBH47p9Zl
	XSstFD9daIS3xAZeQLOMnAjpOn7A75Yza4M4+atotWM6J6gMXWsrX1WihdX4uxCGmWP6ouBCE0t
	XlSM2HYa77QHjMh3HF0rWua7rFs4ZxAvhV2GD5CsbmbQ/N
X-Google-Smtp-Source: AGHT+IEbk5NUcJMVgEAeLPxb32osM2x9ib/KH+2vkyTogXZXkxTrSA3QAaBeQpL6RK3Prv0axIlB3YqoVAI7umsrItA=
X-Received: by 2002:a17:90b:2792:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-300ff100773mr13917814a91.21.1741869508543; Thu, 13 Mar 2025
 05:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307150940.1309703-1-matt@readmodwrite.com>
In-Reply-To: <20250307150940.1309703-1-matt@readmodwrite.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Thu, 13 Mar 2025 12:38:16 +0000
X-Gm-Features: AQ5f1Jp48XVolO0joaqJHII6nYuMdXt1BqKQPbZ4zMS0lcI91QOM1ouPe0h0uRk
Message-ID: <CAENh_STT90u1G1rqiXOarM5O8Ls5CyxTbrh+Sqi9PBqPmg9RXA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add KDEB_COMPRESS_LEVEL to control compression level
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:09=E2=80=AFPM Matt Fleming <matt@readmodwrite.com>=
 wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> Give users more control to tradeoff compression time vs compressed size
> when building debian packages with a new KDEB_COMPRESS_LEVEL option.

Ping? Any feedback on this patch?

