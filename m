Return-Path: <linux-kernel+bounces-355759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D099569B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86E5B277B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A5213EEE;
	Tue,  8 Oct 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZcCacwxq"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA7213ED7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412376; cv=none; b=W0UhnBzijBYLzzLUCIr2UI/bZ0FM/rvyMIkk0DH/kmZZGflgARvh2/6nydbCz7NNqQwG+UvTMpVyp1vknQXOihWlleT3UbKELLgVKiXF+K8h8fEFxDlO21AXt91L2indyZFouxy/oWsWba4+DXd10osVyGnZm0FAC6jWD8Vrzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412376; c=relaxed/simple;
	bh=NdQwiwQuLoS2/vzCdC3cG3nYhs+SrFNqy7Aeb1DsPg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk4qOI59FTpcVN/Sn2u25ERfZpp8u4LwVk68C7n5x9uSPPUWtEY1BRXNu7n9pRidP6FXljuMt6RcJGiL56VVZMeCKq6sGLKHcNbtJ7rnKAM5PT4gBxU34YYimLdjsnL0Lp0HpPqEOZnWrV4FSVC7eiefymFgeAAi31urDRbyTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZcCacwxq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99415adecaso18173966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728412372; x=1729017172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJoPz0THRqBd4HlQLDGinYJ6nPjtsrSYsGPiskCD98Q=;
        b=ZcCacwxq+VVEjOW5ya9FzLeqANYuVfvUrdnn2g/VQk/Ho4OahbmxaPcTfQcXYZxvRg
         DHHIulPty6UecnblgvSDMuAmIgMIauXanj8A181+/CB051+tI8fzVUOnhKGJvsUtiVkI
         dBoSs5JqDG+AvaNIm5KdLIf/liuizNjCSxuIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412372; x=1729017172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJoPz0THRqBd4HlQLDGinYJ6nPjtsrSYsGPiskCD98Q=;
        b=iAmPfQ+YyzTm87aYvfO/WbjCbYFmckMqo6lUXfehdY+px9JTadwR90gtraHK9rtsCv
         axYdeSDVAsRRlepx2jpxXNg5kPrUBA3pm9IPQGUFJNR0AEnkfT98g4mPWqRkcz6+V8QN
         s6KZHE24Rxgehjhl2Q6ind9QSasp2xMU0JsyOZtVtPFZ567Rc6vFtK1kz3hR1EASpD6V
         cOds2mYGaaOib3SG2WHJGn8f0jrUhvZwncyeRL8H9IgUdN77V8ECfWM2HXZ8Rqc4SFGv
         lv+dVHJDJ61Kmcziz1rrEfdn39aZoNL502ny4+4KOqAP8M2RVgRZdwNBZUnTwp3qJZbO
         4oZA==
X-Forwarded-Encrypted: i=1; AJvYcCVgjH/4seEm1soIO2a04Rm8GAsJHaOwweIEf2VmR5oh5I06guEbe9pfRXhI6l1LHYBSLwISNrXblkfhLA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eVJ5wTaZIAetqTJwEAF1E4x/zxtrEePWVpck1DGeMpWgx3UH
	IXPRFeJa3jAgoDJHURAi8LeENOLwHFdOR94SxucBVZP/xTTXb/12v6F9EXhriTW9dhNLywFcLtr
	yImj4Yw==
X-Google-Smtp-Source: AGHT+IH1M7Nt+/AZSfjuOLipH6l1wtKCSTCScc/HDqTPzWlnzZr4Gnhenpv2ZxdjfNHQ8fI/jLeRzw==
X-Received: by 2002:a17:906:5813:b0:a99:6958:a8ba with SMTP id a640c23a62f3a-a99695951fcmr432624166b.12.1728412372335;
        Tue, 08 Oct 2024 11:32:52 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a0b33ffsm489787366b.69.2024.10.08.11.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:32:51 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9982f90e92so19389366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:32:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkC0y55MdS7Ac/PC1lKt6NDhGRXAksSHgoph4zSWZxc33XrijKE7H4Nm/Ecvdgiq1yk4s76pkCXWWcOig=@vger.kernel.org
X-Received: by 2002:a17:906:d551:b0:a99:5afa:cc62 with SMTP id
 a640c23a62f3a-a998b277a2amr1061966b.19.1728412369839; Tue, 08 Oct 2024
 11:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Oct 2024 11:32:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5a-4NGhU4J-PxOwVgNEqN+ZSQ3ZvUMfy5DhzGdZXLmQ@mail.gmail.com>
Message-ID: <CAHk-=wg5a-4NGhU4J-PxOwVgNEqN+ZSQ3ZvUMfy5DhzGdZXLmQ@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.12
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 08:04, Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> Please pull this branch containing ntfs3 code for 6.12.

The bulk of this *really* should have come in during the merge window.

I've pulled it (.. because ntfs3), but still,

           Linus

