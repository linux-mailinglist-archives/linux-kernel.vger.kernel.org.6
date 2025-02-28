Return-Path: <linux-kernel+bounces-537666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C4A48EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C7B189171D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B5224D6;
	Fri, 28 Feb 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aZPRtNlH"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D023CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711090; cv=none; b=m6Xbf5Kqq9JPTY4ln/FsXsUTyvpAAGlgPWRjVAep6AlP/4CWokL3tlCg/Nx0SjJABRtITNF5KwrCqqLvIhmobOqzAT5acJByyvhP8sVjV597+VNFiElL1insloRT1+NIfhpXvWhr/MMmSusc7nKjd79WC4xE+WEUomuXCmqfTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711090; c=relaxed/simple;
	bh=0v+O+z1oQHqj2MSydb3er2Tk/xuiNPbq994y2tUd1WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVi8g4oDt1ARrQ4An0sO4qbukzxVCQfSG6thEBLDV4tVdGqcCZR2hAWFWRdsWQLRkTodnSnn7fXhyIiqeuTyNAFLyOmEuZULzuqxLQclq1MBLmOvJ2bvRXcoDfAnR2LjO4dNAWrixJqJyRt7a34YfByXeS0nkHQvkGRlGm+2Ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aZPRtNlH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso2608630a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740711086; x=1741315886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2N+5JJc+SA2ZKGgBP1q74Ek6RYdKR+g2kF6l/16ZYSc=;
        b=aZPRtNlHtw1xMFLdUvYp0YyMRCSvR4swgvQd/5DBHW6FkiClMytlBaEoZz7cnn8MSP
         bvZ5R1F/VJl8b9xZsajC4kXPhqyMw1id90TOvSo858yDNiSKjpGSAIFRQ7dK2u1vn96f
         dV8lkAByvOC60i/YhqtakR7laxzLDzljMmEYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740711086; x=1741315886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N+5JJc+SA2ZKGgBP1q74Ek6RYdKR+g2kF6l/16ZYSc=;
        b=nAQ9VfAMiwF25gxXaz+V+VH61WY7f+HVDH1SnXKmwEhreyg7JCVzxomC6/qz91sri7
         oGqu7iCLMYVwuXakB61qmrdeSFfN3f7AvuxRz+8teilyx6ddP6Wn42bwtFqj2+3FXV2m
         542JXUeVj7WuI6tABd3Pxz6PS9ODglADlojBDVaYbDISYk9u3q7Smtp8B5WA6KDAYKce
         yyh7cEqTYN2a9apifXGE8cTENfVz2SFGYWeXmqHZ3nl1G1u5EmCAwMW8TMfn0k1jAPEG
         SHGMVKQHu1Jo0GgKnjuuCPyRQRaVj3CddPynk11tD0QlS/BJb+E21NzpwKT3f5J5K0Uj
         KGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkoszbp5I3ae5HkK5LI94JMbwfkJXRyfRFs3rsyZGNXRGOwlegn3YMWgckBjxk6o0JdWvQopVN29AVs1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wUA3bLFShHhopaNpMFp76V1bE4aQok7M7lH1vKLRhzyO8xTA
	AvKG6H0cd636z1ddDNc/5izlLSFZu6DRe3cQfZ4hjJBsXauZfUn9SrrS4EHgitxn0V46LNySTuI
	HbjggXA==
X-Gm-Gg: ASbGncuY4zlok5b8bnVKNVbLNmHY1zI4Bh76rAOoLGWMMquKxlVJY5ICTRwTRg6ECOV
	RQxkvmAMg70lveaVBxbhDDqfpD0fc4nm2rU2byFCHePbZ2eLq2zU0pRpewc2GtVEk8V6CHkLvTJ
	M99ewcsEJL4WRdZFTn3lYX6nIsC5iPVOig+iEym1h4wjZSdW7+NTHW05nAR8erlyehOnQYyLOjL
	rS9q0m1igQVhLGimNawQkUF6SUtGemlR8Z2jgzWg1eYG5wNY699GU/F9Udg2W5v82ORdVG0SUeO
	H4GF6OvRgaS7kTkuXTX20+49AtpMAqevniigUWb+P1qILSeS5/2gasyXtXTGkdjl3izlZp/FGj3
	t
X-Google-Smtp-Source: AGHT+IE6trAD8jIlMkrEy1FJRkMQqV+Gd2kBvOHT68UKWYDqnxgju9dDmn+Hn/uWECjR8bVJy9L/mw==
X-Received: by 2002:a05:6402:254d:b0:5e0:8007:7497 with SMTP id 4fb4d7f45d1cf-5e4d6af1682mr1088768a12.17.1740711086328;
        Thu, 27 Feb 2025 18:51:26 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb4391sm1850330a12.52.2025.02.27.18.51.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:51:24 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec925a135so215008166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:51:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY8o4YfjEM+R/crCgYL7zLFykzCXMp+jYasHONMdcn3gL0d4JoXXdqt7yKDGSFo+mlLnqrkLW0R7L4ZUY=@vger.kernel.org
X-Received: by 2002:a17:907:3d8f:b0:ab3:60eb:f8b6 with SMTP id
 a640c23a62f3a-abf2683a0f2mr155461066b.56.1740711083759; Thu, 27 Feb 2025
 18:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Feb 2025 18:51:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
X-Gm-Features: AQ5f1JqTdqZ-fG1lJ2CuOAnAVjO2mW1kqg7gj11q4lOaIUp8etsT12dAIwUXjXE
Message-ID: <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 18:31, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This series introduces SKSM, a new page deduplication ABI,
> aiming to fix the limitations inherent to the KSM ABI.

So I'm not interested in seeing *another* KSM version.

Because I absolutely do *NOT* want a new chapter in the saga of SLUB
vs SLAB vs SLOB.

However, if the feeling is that this can *replace* the current horror
that is KSM, I'm a lot more interested. I suspect our current KSM
model has largely been a failure, and this might be "good enough".

             Linus

