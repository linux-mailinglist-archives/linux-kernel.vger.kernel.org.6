Return-Path: <linux-kernel+bounces-256728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67215935299
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67ED01C20CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE27E10B;
	Thu, 18 Jul 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQREPfxF"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEDA12B94
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336495; cv=none; b=EVidkVtAFHUOMI3bhdRpxP3LkU5fWuAl+X4QDcsBN3W5ef4hlcZWNNKgFWZlKJj5ozG1DJxm575gkNBd+2N2UirzVKvNWvJVoOWH+rJuNx2zhWrvZmLQsY5esK29PU88BQhnJuPbthGyTrIXyZ2MvOigkTiP98bkamltrcRcxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336495; c=relaxed/simple;
	bh=gf7NKfRRWXLFtuZ5SdFxLPHXzivWHmEX7rQt5mSyLCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3H1r/kG8sEwbGcLDrIedHFnVZ0s3r5qcu7+M4rTTgDa+SwR0/dSUSFeUh2Y1mCpTqTfhQ5yBccHmhgIxgGs0jGfnKkUxIZ8aN+i48U1l26Exzdn1g4xJRXJeOR2Yfva13ZcR+FLoeyCE9UxE22vfWQJSG53RGpEr4zRZbrXh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQREPfxF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77e7420697so145063166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721336492; x=1721941292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ow5FL5EHXdYzigQc/nAruG+c1ufVJ+WXEyxyIP4ul5s=;
        b=bQREPfxFdpwralxPCWRJsAc0LlLpPZink/eenHB/zKQgCRTa44LD72v1M7xG6kZn8Z
         pSryB5PjG2PpXgk/JI05oEO4xOAW0iXj7duOGfEcoxxnIjoI17Tg6EbVlsH8oxkrhksz
         nCYjbEO36aAZOT+iB/d3jjdRcgKeHpyDCKZYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336492; x=1721941292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ow5FL5EHXdYzigQc/nAruG+c1ufVJ+WXEyxyIP4ul5s=;
        b=xF45MfLhbh/lpZdhMm3vYT0qXkP4eVuWV3p1jSiC4ibyFS81/SIr3/A1ZdTHNGNCOA
         8pzAl6+cA0Awmnw8Wur+Y2ok5jWmcaGozSZjuNYIwzps69ct3QvVhCBZxpdVQ6bJ/Sb4
         3fJn72JTYb+tVw0/PhbWVa1nBmSYs8npAoMDYIOGw6oOuWO1i0ADZ2HPzF4HdXJNa8Gr
         ZPabRt2UpfL7O0Fa9e8KY4Xms9L2gcWjCoyM/MlsN8gHW0Qmq72fMpVNCtw1GNVau+1Y
         Eqn8HVdtLkHX0VTmjpRbA3aM8ddcyVwjEt7NjjLhO33BKZz06zanUMHzXatzw9YvpEGF
         2qzQ==
X-Gm-Message-State: AOJu0Yz5ewJgK8kZ6wk+syP6+gBrZ5MRdgatB2YikSpWI4p2aUQLUW8F
	nwEqEhi8Q1RKbZxgYblQayhNI6fhNGuI3l0XKZI3QUTxmNG7zxrYj0Qq9k3HGiJzKFYSqAjT8zU
	hl47pBA==
X-Google-Smtp-Source: AGHT+IHf5LSf6Hdl+DOHy8hFI4IMqRCHYLzuuiYEg5P7n6wRr/vLw8muqMeTmR+TQrI09NCS9nVRIA==
X-Received: by 2002:a17:907:76ab:b0:a75:23bb:6087 with SMTP id a640c23a62f3a-a7a011b6299mr375065166b.29.1721336491643;
        Thu, 18 Jul 2024 14:01:31 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff87dsm600034066b.150.2024.07.18.14.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:01:31 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so266475a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:01:31 -0700 (PDT)
X-Received: by 2002:a05:6402:42c2:b0:5a2:87d3:6ee6 with SMTP id
 4fb4d7f45d1cf-5a287d37029mr899810a12.32.1721336490668; Thu, 18 Jul 2024
 14:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716162714.48febeaf@rorschach.local.home>
In-Reply-To: <20240716162714.48febeaf@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 14:01:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
Message-ID: <CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple users
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 13:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Masami Hiramatsu (Google) (3):
> Steven Rostedt (Google) (27):
> Steven Rostedt (VMware) (15):

So this is getting annoying. Now the company name literally means that
"git shortlog" shows you as two different people.

You're not the only one to do it, but the list of people who do it is
not all that long, and it doesn't actually seem to be a company rule
since (a) you've done it across companies and (b) other people at
google don't do it.

The company you work at does not define you as a person. Really. Is
there some reason why this is happening?

Can it be useful to see where people are working? Sure. But does it
have to be in every commit and affect things like 'git shortlog"? No.

Is there a company rule that just most others are happily ignoring?

               Linus

