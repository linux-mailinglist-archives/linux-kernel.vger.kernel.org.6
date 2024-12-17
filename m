Return-Path: <linux-kernel+bounces-449785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF49F5613
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5351889C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FC1F8929;
	Tue, 17 Dec 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YXIcEioJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7051F8926
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459905; cv=none; b=lLbmbQEyEnkSzQefzpxOqDhvDo6vw07K4L+SuyqXiF0wr4SAdG0kxE4MB2XTz+A5cUWq5BwuqTpZ6PwYEYxJaVUeUSw17GDY8fIv+Rzm8TrS+Duimdm2Mrm1tjHcZ1sUB6KQdWpPm1Uxb6wdfl+eidMhdWsTibcNusWi8MJ8vEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459905; c=relaxed/simple;
	bh=N8eTVIG15b8Txm2GjUbLWrnQoyTPsXqcDWfT1rBo99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbH0vWbhdolOHfAkLdvPFrlzHVJND0QXgzIMQ6YFjqNgpTnwOmf++z9nJKGTv4csCwJ00PlStQ5pvsd0qTyecQrZuko5/tk0t6y9zysIXPi+AqIGRD4t1aifCue6xnW7QjsRzFniW/GX8Nu2Ug6jameGLrat7SfwVJYO0eVJ2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YXIcEioJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso10477300a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734459902; x=1735064702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chiV2kyNC2VPSeaz4uEiEuPCz6nVVRZHgOxSESSDtEU=;
        b=YXIcEioJV2nHsI902XbLLpTVoVeLPz4BDehsMABKR/GVQSe5x8eodwGEU3RdKlVvnt
         zz7cVzAyZn0wSqzE3MqQxAI4jZpc0YcWEaQ3KuNIPns2EvmiIbZPRs40OcqL9dyLxTse
         MYZHaO/OD28TQUpkxYuRYB6Q9felVsCsHQags=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459902; x=1735064702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chiV2kyNC2VPSeaz4uEiEuPCz6nVVRZHgOxSESSDtEU=;
        b=F3D0AhhTroPULqC4m1vLmxBo+XDRZq+yw+3MqO3CuTGwYwA1qyuep4nPwiad2TGiZ6
         OxwabXnTDTas0k+KHsYYSDmBJq7r5hY+/bgHAwgdqTAFv6T80TOKHnJrnKgLzGHyqcVL
         gIR+qhGGiVWatKTWXsw9ABxp8SJH517Ii1hvTALBPOAZ9lPsSygKChUp1cj/UiJEwTaf
         fmiM6ISy00ocCEKyT2ugDjg8zccdsN15T3j2qZNiLtDkIKq0aZHfvWTSEkIDYtKGhiFm
         B5tex+z+9Vv2YCnmm1TQAHEB+sqbCYi0vPBJFzaKiTqpOYAziK3QkSVDo/dkN8dGbhRp
         nhUQ==
X-Gm-Message-State: AOJu0Yz5M2Mk4pOAeUqJdm6C0QVYrqYJgeh1jyQMXaTx0oPHT7wn7x+U
	/C9eZvSRx1MS08VDJa9FBXJF5c2JZyhZZXsz9b2H5/at3HXzS+itNLdPPbyeWgXj0Z2IhFHibx7
	35tU=
X-Gm-Gg: ASbGncvYKhLxp9PUO50Z3qATmwtsj/ZFzNXWmQCTTAjXUrdAX1vhOeMIQJK2Lr4IA7o
	aoaRraMPZlsZkvnoDulN0HSxQYCnJ/t5iVwa7iGcHxDaVyQkn+GkmNVJl2DXzkGBUlLwIfgpXfh
	y3Iuvw4HFKKoUIqaZTJ4qefdI82MCLpPrT4VfYPujzeAPvotbSRpBTI3pvsp3Idp5t8vfYUnI2g
	qe1sh+nVDmId0sVQlSkg74LmL51EYZ2itfXJxgAVL8j/T3+pyYis0lao0yozNhtgNntOgLRRhgC
	nD3XSf8TwjKhlgJOXPvZPmCn8ORg3aQ=
X-Google-Smtp-Source: AGHT+IEpywJORKEJVNlJpCtmtaGre/e0iZL1yYTN0B5ZaYtjjZpcMUgCmrYgHe7Zp2oAwTRAqstkmQ==
X-Received: by 2002:a05:6402:5207:b0:5d0:b61a:89c9 with SMTP id 4fb4d7f45d1cf-5d7d55741eemr4505400a12.5.1734459901721;
        Tue, 17 Dec 2024 10:25:01 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f35aa9sm4508047a12.84.2024.12.17.10.24.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:25:00 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa662795ca3so1272376466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:24:59 -0800 (PST)
X-Received: by 2002:a17:906:eec7:b0:aa6:841e:ec40 with SMTP id
 a640c23a62f3a-aabdca5bf6cmr338877266b.26.1734459899304; Tue, 17 Dec 2024
 10:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
In-Reply-To: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:24:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Message-ID: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What *woiuld* have been an acceptable model is to actually modify the
> boot-time buffers in place, using actual real heuristics that look at
> whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
> of the previous boot.
>
> But you never did that. All this delta code has always been complete
> and utter garbage, and complete hacks.

Actually, I think the proper model isn't even that "modify boot time
buffers in place" thing.

The proper model was probably always to just do the "give the raw
data, and analyze the previous boot data in user mode". Don't do
"delta between old and new kernel", print out the actual KASLR base of
the old kernel, and let user mode figure it out. Because user mode may
actually have the old and different vmlinux image too - something that
kernel mode *never* has.

                   Linus

