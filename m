Return-Path: <linux-kernel+bounces-421389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB079D8AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156E1168D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F31B6D0F;
	Mon, 25 Nov 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DIkZ12zo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDB1B6CED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553633; cv=none; b=ghWOW9FUhBBIPMDkSrPGWP+0QgZ5ySluvOccO7NiIyLW+vhG5alL9nZFXHI1i/aX9GRNJqJQyJ7r4iCuhy9GiSNE3QXW+81bRDJ4lmrEse/g5ICecFq0KwWCeurh15sUMteeQAE49cDuRmSsc+tMSwOTWadiYYNyTyOotEupRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553633; c=relaxed/simple;
	bh=5T71W2ybz4LcFji5huscS1t9JnB8RFZFmApSJDeVH2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0Xsp+IcZapF5P7QkFXSqeb92CEcD8jBdDxwBqJ7UOvN3o3tptUJdBTrsrWDBI4pJKo3+Vm40de/AErWpnREaou2RTg9lg83R11xWmQBSIg369rljrZDL3R9R/C1rwvBOzD4YYvsqeD7FU0WcRnfPSs/au8xVju36UgpaGErTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DIkZ12zo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso2209925e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732553629; x=1733158429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Di9miGVwG+zuI8yL5QK3cnRmWwyZdpSGfLeetKple88=;
        b=DIkZ12zobUuS2OPAsjVzJprN4c72gTzToigQ7zchyCU1Vdg2zvfiIlR+m7pyQXNMW5
         tAcTxP2wY7mTuyj3lxs3bYrHbwm9ewQmfrzMHfQHTttFv6NrSjABZ5PoT+QKMihx+Qxs
         FLCPwmYRaWEMeLaBgqTgkZCxVrdwtCYTBQ/7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553629; x=1733158429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Di9miGVwG+zuI8yL5QK3cnRmWwyZdpSGfLeetKple88=;
        b=UBAVjdWc58cSPE9gnRUgImHx+Q8Lp7kRv+hrXJJb1X24KJ90npjedEkuiRIUPXaoAC
         3nhcnxUneSzLobM1GAKpKHSaHG83uojARk926isDszfqE1vZ9fH3SpfrVmgFAruKHjxU
         f2CUPvdmjbbE1nUgzyP6TmGQMWlb/cDY97CFMCoZn3/D8ySUfR7DgRjyp5bbvXYu1YW7
         1Pt5PnQtzU/Xb/QcQt4q8LAG1Smdm7dRAE3mmCpe9AgzOnEu2M58/n8a44rzNmlE9wdK
         zqiBD/a9Mshk0SENpoKKHckq7yjsoJi6HKwLV9fzD87XRbAqTlsAnPY+UhAB8c2OgpN2
         eupw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIeW8kDeGhbnUFSQNIWbNa1BJ6HmBR4nAWSI5NYcIyyW0aSBE6K54tEEH58q9YlmvQ00gobR0MyociIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNQMBl0RhTbI9vwye+cz/dRdC83SUqFSUmcbPidr5Z01sxFRq
	3guwL5riAXt1R6IcNvBkOcLzUn9B7PGgj3JzdmyJJdEh2dnBXy9IIMdBFDSgJqTk9ucaN3sLVEC
	47osVAg==
X-Gm-Gg: ASbGnctyKk7dK+ncQAD//P6epo2MmLyOF5+aDr0DIS7eppRYHI3f++xRZPu8ZBciB9y
	mInV7uwzFIXvN2AqQsYS1EGvp7AqdySIiQJL2ziHd7vsUmuO6w+S5dXBSQefd0RBCCRXvOPLrtA
	HKpnweb/QFC6VGFDEL4SvZBKase+4tRNI5c4cTqAfI69ASYrq0UfNuB62CWUgrS9TYSJx3VSvtJ
	I8gKf/+pBkjE16hLvX+vSc1heiUXqPk6WSNAtbjfXzjZftin1hpk3B3m8jRcEqDsR+RVGRbRWHR
	xuJXvOLe7V4XPFN15b+XDcYU
X-Google-Smtp-Source: AGHT+IG5g+0Ujmox7TZexjmJHI3Gq+NJxk3/H5939ljvKC1LtPkyic/UTmwnW0l4vWSvUaPQ/EitRw==
X-Received: by 2002:a05:6512:308f:b0:53d:de11:7749 with SMTP id 2adb3069b0e04-53dde117bb4mr3111617e87.2.1732553629430;
        Mon, 25 Nov 2024 08:53:49 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd6cf4a96sm1498432e87.167.2024.11.25.08.53.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:53:47 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dde5262fdso2232540e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:53:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7BPHpu5/DfjkY+D5+vC+DcPn/jZqntEomu9EFaMoCxXr/4z6RjmMN7FnxoFy3NeOlYjUfI0Sc8bt/y9I=@vger.kernel.org
X-Received: by 2002:a05:6512:3103:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53dd39b15b6mr5985585e87.35.1732553627351; Mon, 25 Nov 2024
 08:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 08:53:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+R8zBeMZ-gZeoKCw7QO4-0PwktQaEPvtEuE_4o3VUdQ@mail.gmail.com>
Message-ID: <CAHk-=wi+R8zBeMZ-gZeoKCw7QO4-0PwktQaEPvtEuE_4o3VUdQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 06:10, Christian Brauner <brauner@kernel.org> wrote:
>
> Changes in v2:

Thanks, everything looks really good to me, this is much better than
our old refcount thing.

          Linus

