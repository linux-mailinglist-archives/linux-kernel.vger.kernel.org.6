Return-Path: <linux-kernel+bounces-543085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3CCA4D149
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B011742A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069413C918;
	Tue,  4 Mar 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZQ91vAb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43013AA27
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053409; cv=none; b=igNmaJZ0d0PeqMjkmUUD0lZneRy1QmXeUwYLNp3djPztY0dP7t7XSEktf/W3z8tS6UIIwb/vK13qiinEkqeTFrszVNPR4Gv7TcxkTNXBaLzJE5RneOHx+AdkowdB0D1oGDhYijJYUXCPQqvE+7O7xYi4vYNPAfuxSuul+iXFe58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053409; c=relaxed/simple;
	bh=XogSGIFusThCkYAi7RyBfqCqvYbUSJkF3dde+0TPxVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBAah21MFitsyoRxJWUOto0zhtQ6RzUR2mejDTtdtOOrIugMTB3buFzLWqG2x/rTLTM8rHfUnatIiqQVN3W9znhNWjOk5/YGwnc+YslJRSbfPXLEfOp0dx0XWUQ3IFiQH8DJJGo/53VtCdlYRM857JHXERGQatoZ7VOpFO+Zb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZQ91vAb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf48293ad0so472009966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 17:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741053406; x=1741658206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XogSGIFusThCkYAi7RyBfqCqvYbUSJkF3dde+0TPxVE=;
        b=DZQ91vAbMeoLDSUBn5OGr22gnV/8hGIOOuBOh2oieRd/yDYRD6KKqJAKrY+/qsNenJ
         Lw9s2JniSxhy8GtfL3bchOCVeKQd5n4J4ar1OE99GbuPCXj7mUJ3YigUFecp7PWjMImv
         CuBENIRKawI7kGKJzJKlzPpPCoM/lvJt1WJ0ZCqutFOGfEt/5NlLDh3gTvCVmlZnInAf
         PX2M51zISE4ktITz29vxDtfA2+7nUPl0rvB1DclJ+N3l+9iuFDGiZ00HOLC1gy+6MyQL
         xtJm/iAFo2Vy3mIbd5Mj8T3o3ZFQI7r/QbPGW1TSOvMcBSRhQis6g6xs4u3g4pg9LGLC
         LIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741053406; x=1741658206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XogSGIFusThCkYAi7RyBfqCqvYbUSJkF3dde+0TPxVE=;
        b=rSsDoxmAhinrfUDyn091LLfz58BYHfFkosO1lFco1hdMh4W+V8yawNtwuKPaX15J/u
         HEwqUe650fBovQpFVGDrYx/HWZDa+lqX6u+88ntYPNLLk31bIiSS5sjLBPIGmcw2+4Yc
         W3iT1w8xi9o8l3qDU72CAAaM8XPAkxTID444aJ052R2ZE5i5VXJTgH6KvYtCYAKJszGp
         m6piIYpM1muW/dRSaYDtoBBx4xkKVhrX71d7t0r4qbJ75L5o9B8kLF1L1EoIByRsY40x
         noQnEFS/5ud6g7KYoR8ie/T/jIV+eLX//6YkYhxPFhVOqMUHYJjJySOoUin6kRi+IXV9
         zKsw==
X-Forwarded-Encrypted: i=1; AJvYcCVCvMQPjydRhAwu0ILIyZYgYh6LThR7R/a34gqVRd/6EPZdyg0uzlf9HpRfmY53ptNkewhY9E5zZMAsjwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVrmNcAcS6BTxUFTTpM6IP1fa9JsDibihmVhF0iY0I1z/O9fn
	rzarIK5Z5HPcqNnRWiXrSouI7dG13aH5jAXAahwMiYrKkl41s3WG7tzs3EZXnKjBAwkupAjXfP8
	Q9P9PUW0PJLJFwu39vdN4A8G0D3o=
X-Gm-Gg: ASbGncv9158ZI3WsJm6h54X40gvojhEr2AMqF6Dwop9/un3xe8xaBMZ2OJoXObmJr+i
	MbAKthxKqoFBkMK/z0ROlfZD3ey/+5iQq+sFN3Sv/mYtgK+qXvEPaqlInsrluSOJ/Qn+nZhxT3Y
	NHMCBc8Y4fw22KoliABwBGr7owlOQ=
X-Google-Smtp-Source: AGHT+IGFGlf/Tw+p7cxh9KZ3JgKrZRcBulXTyPodYrWIRFPzM9fT/G8aIuBv0O5DanK4nJA2rRBhxy0PhYdG3ACdKqU=
X-Received: by 2002:a17:907:7288:b0:abf:5922:b7a8 with SMTP id
 a640c23a62f3a-abf5922dccamr1498289666b.41.1741053406293; Mon, 03 Mar 2025
 17:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303105241.17251-1-xuewen.yan@unisoc.com> <20250303120021.GA11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250303120021.GA11590@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 4 Mar 2025 09:56:34 +0800
X-Gm-Features: AQ5f1JpJr_Dcm08RrotlVGYHmZoAIi8XkvykEcoVza1rNg6D8yeSUERcqJdPAAU
Message-ID: <CAB8ipk-pmSGoaxtMGhcvn7MmSEibvQDbCDgjp9iEDTzG5=_L7g@mail.gmail.com>
Subject: Re: [RFC PATCH V2 0/3] sched/fair: Fix nr-running vs delayed-dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter

On Mon, Mar 3, 2025 at 8:00=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Mar 03, 2025 at 06:52:38PM +0800, Xuewen Yan wrote:
> > Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until =
its
> > lag has elapsed. As a result, it stays also visible in rq->nr_running.
> > However, sometimes when using nr-running, we should not consider
> > sched-delayed tasks.
> > This serie fixes those by adding a helper function which return the
> > number of sched-delayed tasks. And when we should get the real runnable
> > tasks, we sub the nr-delayed tasks.
> >
>
> Is there an actual performance improvement? Because when a runqueue
> looses competition, delayed tasks very quickly dissipate.

At the moment, I don't have very detailed test data. I've been
studying delay-dequeue carefully recently, and these are the issues I
feel might need modification as I go through the code.

Thanks!

BR

