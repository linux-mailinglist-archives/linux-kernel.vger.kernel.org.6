Return-Path: <linux-kernel+bounces-342015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935819889A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C378C1C20DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D81BFE18;
	Fri, 27 Sep 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="chxe8BFn"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B213AD1C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457827; cv=none; b=rrhEWu9H3jGWg+FZYYmcZOyUuNk0lY4icqIYLkl7NVoqNEDxoUcLTgzB4hM3mtQaMxEJKlOkaAn9Y5AnUqtNBf9+C2O+YkssT6uHZzlqymSkmq1RQJTICsRMhWph+CxVK847uHZOpDlsgboc27s2T48vg8gaGUQ4SIWjAJtZ56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457827; c=relaxed/simple;
	bh=GCk2RsM5FRN762nuUdIVnJyHlR1/BB2s3RYsgpZTJI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB6p4RuLNEYnSoPAmgLjqhlt0PFoctYN1yIS8P7YMiKbKowZitV94MLYZSGanZP3rB0Tk4JGGXUrhi6OrBewUSj9ejXHdqvH79ulU0dIJo14Qdzp78WN5/Ozm6kO0Rhj8tMtTxk3d0Hq5lu32VGlfzvOs+XC0xEsRXxydK7R8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=chxe8BFn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cdac05af9so728004f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727457824; x=1728062624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pL+eYyAYNBlL0JEzog7gteLEL6jaNxjttyWOz6wubk0=;
        b=chxe8BFnnG53/NvDoWaLWwaz0rQJtjsL9o3cpflskRTlZ58LGrxiWIQ8Qx34RaCBjX
         kT6MpTKtCiHKVT9PnwqbgfExKYHHIlm6dK9cZyqAqwyOSDj8xGMWRMccnx6Q+UG3dIuI
         WvWSQYP02ozC3WqOwayjRNDDBRNHoF1OlQUCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727457824; x=1728062624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pL+eYyAYNBlL0JEzog7gteLEL6jaNxjttyWOz6wubk0=;
        b=hGsWlPHh+oZBwjeWyIL8KFknUtHyDyFvMa+l2bO1cPcZUlOx/r22T6oC/nRIkPhUk3
         nFo7TWW3vZhZYmsdm7ZNnah8SlfedIUEdTjXbobxwb0tvI/XFzG4evnCJUG8iF9UY0V8
         ihEHJKY0+0rhVC16boIcstq31uFEtS/2w+f5ze08ljGqxgccehXLfjOGy7wXupGLDc//
         OHUyz16Nxpjr78nqSZrLCXzXcQrfEJ4Uvau4IbDikimzpqdZsglJ1rUFTy9CLtOu+emj
         e0pIrGyh/+SQGJ3hh7OPB/zZkopcRg7LhPf4Q0+ehxIQUJPauIfI0g4XRh3SXc6vdfPA
         O3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjUmGDtg05W3VxPCBxYSFdhC7HeI0b/3otZaXTeXkPQt7+LNSRcZDkHIewpXZTMkXQgQayMagjlHBYzYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CfSfg8D1beATKU9MI0nnHZuYerxN498hD60HOUGwqMK/J11N
	kq+YrSzcZnOAFC7Zmf0HzqfSFpjx4Hbj5QEUut6MOaJkkgMYNaRIhanlnVwswDJXdhWz3vfsEpo
	jzYG63A==
X-Google-Smtp-Source: AGHT+IEE47iFW/XQTJ2zLO8kXQFlGaQCh0NhAto4MOtv1Dp6EfMVk/cICQU/EHT5j3JARgOvMHlg6Q==
X-Received: by 2002:adf:b31a:0:b0:374:c3cd:73de with SMTP id ffacd0b85a97d-37cd5ab1164mr3873846f8f.35.1727457823800;
        Fri, 27 Sep 2024 10:23:43 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb40sm154062766b.181.2024.09.27.10.23.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 10:23:42 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso2367447f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZXr5Nlnlu9B7aIWLXBFrN8QKi36b++xAM+VduFG3B4sv6KgNDKISD4jePgNwkG/zyteQRh9z0M7epbHw=@vger.kernel.org
X-Received: by 2002:adf:8b1b:0:b0:374:ba2b:4d1c with SMTP id
 ffacd0b85a97d-37cd5aa684emr3408839f8f.31.1727457821824; Fri, 27 Sep 2024
 10:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux> <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com> <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com> <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com> <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
In-Reply-To: <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 10:23:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
Message-ID: <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 10:17, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The barrier() is ineffective at fixing the issue.
> It does not prevent the compiler CSE from losing the
> address dependency:

Ok. Thanks for actually specifying code.

That needs to be

 (a) in a comment

 (b) the value barrier needs to be on *both* values so that the order
of the equality testing doesn't matter.

> I'm preparing a small series that aims to show how a minimal
> hazard pointer implementation can help improve common scenarios:

I want actual numbers on real loads. Just so you know.  Not "this can
help". But "this actually really _does_ help".

                    Linus

