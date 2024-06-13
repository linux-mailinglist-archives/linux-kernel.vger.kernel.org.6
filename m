Return-Path: <linux-kernel+bounces-213808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4550C907AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74BF1F2168C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDDA14AD38;
	Thu, 13 Jun 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F5mNSRSj"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FD145B2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302695; cv=none; b=p8mmdFFRP+pd8mA6FXqcmzXNDCutDwm4BIZ1nLgPG4uwxxZLHr8YM3N59PeJg1SGO3DDkb0JxHlSOmQip5jdnWO4J2N89XSiDvgttLu0SA+YybcYg47zruerx3L3uS4gb+PY6h5oMVwwIypEd4QD3NXP3apy9ZF4psn5y/zy08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302695; c=relaxed/simple;
	bh=VmpvWSzugIB9sHC+Poxu1Uf7slG8yypxWRCwzH/6k54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moor+z6VwYQKHZJ7wIX43BuzfGL6XhWgphhMW+tD64n3PsuQdk9lvt56xg8S7ZD+4ZTAaHOXfgBwKSs8EkM5UeJhdO0mvLgGrEfTOpwGKKDYrA2O5IppZw15jxFvZcHU/pBO0co4yqVRbSXXjuV6raK1dllhPP793Bk102nTqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F5mNSRSj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so794053a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718302692; x=1718907492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U32F52trfP/t5Glv8Me8l9/yxhLD4fCfQobPR+5mCxw=;
        b=F5mNSRSjAu52CLrx04TXMLC4Vhr4g9h8VsX19HDB5jPpAZ5frUAdDnlT7Jp1I9Rd2s
         V3p002ahCms1yULelSRlJyYF3MJqvzZkgP25Ib+EDbIekl3PKqNJt7KzLAv+0R6UgJD5
         nlGEHYGDzAIdQS9QQEynfzEckMv2X668eGF2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302692; x=1718907492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U32F52trfP/t5Glv8Me8l9/yxhLD4fCfQobPR+5mCxw=;
        b=sZo7Hbnpt5Slk+uClCB0WcX3lF3lumWkm9uZdCjkoXTtR48PGbtUWJa0iH1K/Xcdw5
         1Fv5GeqeG/zJVOHjpG078GDhEsvyQzkvlvS7pDuz8wb884DUi66IG7IB7uYp6a4cff1v
         TyaAGHfMUfnI+l3PJZbB9czq7JM6N3+ZvsuhzovlziACGeDNgJ9eLtvLe109xXUrQ5pV
         6CW0bawkVa/dqCFk4XTeHJ2OtVpsLMov1U6eu+zjPXtqrTXxYI9Sui0fQeEdgFJLcSGA
         nOob3zVAh9Fxw3TpQdiKG5ibRbpPUj/zBc6N2mb+SngOsZk0+opKf299XHJvkIz430fJ
         sUUA==
X-Forwarded-Encrypted: i=1; AJvYcCXA6pUXDOeVPO1xCkfqkL8fSeb7/sYeSmnrqWwstAoCyixVb3+JGC2AFDoRvE5pIP6TRTSwoccanH4+6IJwz6s9c9LC2IZxM+TeXjBq
X-Gm-Message-State: AOJu0YzUF9SItGjX2sFU+VZtgknQeoT7EbKqFudee3E0ehyNC+1wJygR
	vIoBaYx3aBVb6gHGrPbMKLNLNOjbDzuwKrLkQymZL7kB4XqUeYY12Hua4vdiecge/EyQkO6yP6m
	rjn7SDQ==
X-Google-Smtp-Source: AGHT+IHCfEc8rvXtauCpCyx2G5lhN19QKh70C5zGQlst7Z8Jkm4whvjC6sizZcN56nMW722UuVnR7A==
X-Received: by 2002:a17:907:76d3:b0:a6f:4ae3:5327 with SMTP id a640c23a62f3a-a6f60d17044mr42360266b.15.1718302691118;
        Thu, 13 Jun 2024 11:18:11 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed3658sm96704766b.133.2024.06.13.11.18.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:18:09 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so793979a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:18:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/tqvaIyOQjIisfwjmZFD+BQGriHz1ypjssGLbaYkBV9Ymt9P7LHnGrDVHLUXZrj0sa3W/j+//W07JnW0tlxk3kUoEZQVSZVjkWOdi
X-Received: by 2002:a50:96c3:0:b0:57c:9c5d:d18e with SMTP id
 4fb4d7f45d1cf-57cbd6a85e1mr446474a12.36.1718302689163; Thu, 13 Jun 2024
 11:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613163542.130374-1-kuba@kernel.org>
In-Reply-To: <20240613163542.130374-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 11:17:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
Message-ID: <CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10-rc4
To: Jakub Kicinski <kuba@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 09:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc4

Your key had expired, and the kernel.org repo doesn't have the updated key.

But for once, the key servers actually did update and a refresh fixed
it for me.  Whee! Is the pgp key infrastructure starting to work
again?

                            Linus

