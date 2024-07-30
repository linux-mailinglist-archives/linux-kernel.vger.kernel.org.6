Return-Path: <linux-kernel+bounces-268268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA7942266
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EF01C22FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320C18E059;
	Tue, 30 Jul 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnTa/3zS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0161AA3EC;
	Tue, 30 Jul 2024 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376725; cv=none; b=s7UnMsT9PmC9HbJsWrL1/6+nZUca/yXoiRh5GNM/tivFPs+r5IV3+kjc+QkbziX8aOyXWyBNWgX+P/f5m4PmVlPdPDvfksadh1PGjuF2BoO9E109V7sIZVQWm2Yq0zAcQHwFLlnqtO+Y//P942ftb+ytA9I3bkt9NWqdXGJ7iOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376725; c=relaxed/simple;
	bh=osY4LZL/UrSHe+cCINt6o3dd2Sm3fHb4wWmKLKQnY+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEWV7mbXArFidM3EB3zsj6MqP9tjglvGwZPb5VzPsW5mKXYABKhwKdJvIpjuiOg4TcgvLKvB1El2iQY1T9wymDqvDQo+GBjgADifLs49NPioREt4AAxaRNezVSYag+doyqSCbbbnjncxgEBW3Abp3EqESUqUSkrNtHu8KBAQTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnTa/3zS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so3320177a91.3;
        Tue, 30 Jul 2024 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722376724; x=1722981524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osY4LZL/UrSHe+cCINt6o3dd2Sm3fHb4wWmKLKQnY+E=;
        b=KnTa/3zSmndwHwa0luuSncj4Da3zX/5s8lgqbVHTqYKfX/ZcNvNJYWGqp2gISWELGa
         +12TNzrZqUTZohIkh1RK9WCgS9/mE2UYuI/+Lce/hwC4Mp570X/RzWXg+ZWo6wPZ+jN+
         6c6K0FLpn02apt8LmaNPpqF299WIv+1+CkjxDaYab/Pnh/oHPPfwtE2/7Q/gImskfNp8
         tI9ld7vayuu+xlP51BvgdqXnKnc572ZbO8nS2CmXDxe/YbdEkwke1S6zWC+Kh7a+1vlL
         eMwzaOV3rwwwMGNUGJKT16U+zqlGj1JEpjcl4F8WQZJuprEN7o8buttH2k0CPevSYHAi
         QLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722376724; x=1722981524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osY4LZL/UrSHe+cCINt6o3dd2Sm3fHb4wWmKLKQnY+E=;
        b=Tu9HzpXuIRjmyKl6GOEbpFlEx6eI+al7jCECsRCZ0LN5Ob/ZnhNXAIIuk8Z9SMX/wt
         7Vc1/Vj9sfAUISCHSkO46rtylezdC6ZdzKs7MLasDXJ566JE4rUl1GzT0OXKpxWZucU8
         3s+ZlROcQYJYLPLy6lIigQea+T7XUzLOcOwZw+xSrSrZRu0iM2OZTBHMS2ipFHR9eIMF
         iESY4aqs/KiWmPMjNG1RDdXxBW7UNCxMblD7IqRJ6NXc/Ao8j21segBZhJAGy9td24Te
         jqhXjCRJgC+KSrEJ1u4bmC94E7JisnPG5diV8twIFpVbmu7OHw/orA9mewHz24Zu0vRS
         ZcfA==
X-Forwarded-Encrypted: i=1; AJvYcCUnGjASLk3iC8XEHAo+3O8G8nqNfCUuEAe+aGV5HIApthq4PrXLYEO0+PZClV15QWPjhsxG3KhUZHQubr+LU+9J+a1olBXq3/UsR9xsP88+CLXI/ZLTCgfJ7bLbVluJijkNC09nFVNdUKw3biktClzq
X-Gm-Message-State: AOJu0Yz5BBwNx45tT1P1sXWdjqbTOvadWIlJerZoU/ZeRmlPoOwBGoLT
	7zZSKIL9xOdGApxRXVuGTQpZx/zYo8t1Ny7IZLoslRkUlsKJS2FBQFTAWoOM6eXpO4yUJeF3gXn
	7QDleOZrHG4u2vRam+MIzHqaAx/4=
X-Google-Smtp-Source: AGHT+IEfEIst9ItvO4ZH34RuLPBfjrhITyp/hY3Tg/W90mzLDfSmhIJCp3woSToPS0rwFv9MY5KPOmL+cp3l1whUN98=
X-Received: by 2002:a17:90b:ec4:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2cf7e1a1eacmr10879908a91.5.1722376723798; Tue, 30 Jul 2024
 14:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730123421.GA9085@redhat.com> <20240730123457.GA9108@redhat.com>
 <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com> <20240730205526.GV33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730205526.GV33588@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 14:58:31 -0700
Message-ID: <CAEf4BzZT8DtC6vvn8ZD1uKjxEzT32TTjKmzixTMy8SyzbKvstQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to uprobe_unregister()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:55=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 30, 2024 at 08:08:49AM -0700, Andrii Nakryiko wrote:
> > Also, can you please push this and your previous patch set into some
> > branch somewhere I can pull from, preferably based on the latest
> > linux-trace's probes/for-next? Thanks!
>
> I can stick then in tip/perf/core if you want.

Whichever tree you and Masami ultimately agreed on, I don't
particularly care. But yeah, this would be great, thanks!

