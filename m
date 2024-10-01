Return-Path: <linux-kernel+bounces-346355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C631898C385
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D80284179
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34FD1CB521;
	Tue,  1 Oct 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Es6ZktY+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33771C9DCD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800598; cv=none; b=oHmU0RxyKqEH6JBPnSg8RR5JBF6150b8ugrY+rujGhcG46bucVRHdSnlTdyIKWKv5aD0ZT8ziPi3zgOlGcP7EGe+tNJVw7308ucFBQAYCpwqbocd+1AqN4nFOUSKMoQ03Eofyw73l2c+7k42WtacQZIylyraoBsYGpD+8onlZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800598; c=relaxed/simple;
	bh=0sM+nrVfacbvTFodxDj9UKhTC/YS1eRFcVZP+fkLohQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biPbSFKgyxGi0GsTDya1boknRMaMJS38PA8vihV9S8XSyY2KLyVXrOXfuBzf/9dXrKlJ6nKqfiX4gxDepPVVq+OR+Z5VRC8mf2kZMhp7zHS2uDFJSQ+6PU9k2z+rR9nCrjb5/Baq3+EEDJov7u+ueyj76xCXW/KhEKJGFr8qxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Es6ZktY+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8ce5db8668so993649266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727800594; x=1728405394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxJ6pGYTMNRfHwEGgEc2uVDA4qU911HW1i7xc0Dagg0=;
        b=Es6ZktY+qX3Nn6aLkLWM9JTp/YM8yyQXmq/c+tdkMrPXumWuDnBey2FPP1lQFyRoa0
         tepvrQNxlO8zaC1b88qzyS2veiJt7e79AOutq+Y7g9PP0BStJI4z2I9MefN9V3YDqaaU
         V2vGicKQUZybd4QMbPKv9VVnczfBz7lLFpHd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800594; x=1728405394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxJ6pGYTMNRfHwEGgEc2uVDA4qU911HW1i7xc0Dagg0=;
        b=El0zCCaDezE9s97U69tfSXi3z7rOiJ1oK2+AnwPM9KpE8tPxGHfRmxQGp6VnSHtReD
         BRy+/NegR6VR3qJZxB7g3dsmfqoQ3g6CWVxIHSvnqPqJ9vXTLmw283L//Y/wsht6rpZ0
         5wtFZSTIqS+e7XcZM67h0koBlv7UEcJLK5gnfQ5IPY8Rc0njBBNLXO2ZMw9m2gK1EANS
         ViLW/d3PO7GdZEpXl6xX8HOogPwxqbn7Pbr9U5fw6SeW8N+ZcbhSWJ1GZvVud9bzwd5C
         wKzelQKRtH8vf5Ifkn+0Z1McXD6KaDXFzONDKh+K54tvB4uPbldIAYUgFFSdIB5qYZUU
         dzsg==
X-Forwarded-Encrypted: i=1; AJvYcCWQc7jzZipfRENTTz/A6o6TTErNw/myZ5e4262HcXkU8nSpX6kUeT8Mv9EKjN/ClE5dZ5rWW4I47hQ5fCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOe02VXcq2S/HNNOCi96khGjM0vmBQeFcoiWV13Enxa8f0IMFF
	PnsG5/FlGzIzS75L2Hygmh9wjkOs+6eKODhoOqHmngtyJFTdc06rMyEJQWAQ5jljt8w6fJwHxze
	ihNhlOg==
X-Google-Smtp-Source: AGHT+IGCCR4aSxAHPTW+2RXsPQt/TcnNtwnj/msd8F85rfzXYDQNbjUoUmlJARl6TVCjHDVVGdpckQ==
X-Received: by 2002:a17:907:3e87:b0:a90:c411:24fd with SMTP id a640c23a62f3a-a98f8207aaemr18986766b.10.1727800593961;
        Tue, 01 Oct 2024 09:36:33 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb40sm730707766b.181.2024.10.01.09.36.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 09:36:33 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8ce5db8668so993643366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWs6k7lF1fRm/cm1oK+ZtJh/zTVde0jfBCG9mIXfrkIzn6sMCBRRru/Nx1CwZHTikrmalg6x6tcpxrIIMc=@vger.kernel.org
X-Received: by 2002:a17:907:96a1:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a98f8261ab5mr17931866b.32.1727800592814; Tue, 01 Oct 2024
 09:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
In-Reply-To: <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Oct 2024 09:36:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
Message-ID: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Paul Moore <paul@paul-moore.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
>
> Linus, it's unclear if you're still following this thread after the
> pull, but can you provide a little insight on your thoughts here?

I absolutely hate the whole "security people keep arguing", and I
cannot personally find it in myself to care about tomoyo.  I don't
even know where it is used - certainly not in Fedora, which is the
only distro I can check quickly.

If the consensus is that we should revert, I'll happily revert. This
was all inside of the tomoyo subdirectory, so I didn't see it as some
kind of sidestepping, and treated the pull request as a regular
"another odd security subsystem update".

                  Linus

