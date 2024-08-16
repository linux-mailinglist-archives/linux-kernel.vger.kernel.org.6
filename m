Return-Path: <linux-kernel+bounces-289481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFBE9546A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820301C21C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FB17C9B6;
	Fri, 16 Aug 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrH3su0o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F34017BEBD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803571; cv=none; b=ZcPgvltfGLLh6bVJQPwO5igRnMtosMjQQ7eTY/+EhMJJwwH2kcAHd262CW1R3pug3taPCesAffmZUKeHEMXQ2sij0jhipVMNjgRuA2jiPHuJoWfoAO6K7YEcya5S1LWLvZpy/NOAt+QtuhB6HjbqMwsJOxGwYyn1/2Bepy9jSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803571; c=relaxed/simple;
	bh=WoDzLJGjLd7vC+WnknkQjgT7+H9CRmytRbPgbaD5W3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eaAE/GS/0FauySJ/qj92mSyM+7ezmV8ukwaOKCBGyDNMCbQIViozlMsRzzFnRQsd28oZnKFHqAQUJl9Q1dc8y55zMdmBTEsW/aDzdtH4+9kKNLXRhqfuxyHXxxOF6rdHCu28PqMkuVuwzoa3gdNeWbuJEdZF+Vcc21jry4SRbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrH3su0o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723803568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoDzLJGjLd7vC+WnknkQjgT7+H9CRmytRbPgbaD5W3w=;
	b=VrH3su0o9EPn8Li4/+C+9NscvJw7uBGLfnGkcZuMLPNoejNxH++BRLBUPWHWs7cVdPubDy
	R23DvG2uQFqsSZ706iY2kCsbX1I5uk8ErAJY8zW1hCFh65xahiUxwgsY8bz/0Xmlb+KJAc
	d3sDwkCwH0fq9LhCvKzlVM0SNyl4ckU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-2VsRh6oKPm62xRawHfhVNQ-1; Fri, 16 Aug 2024 06:19:27 -0400
X-MC-Unique: 2VsRh6oKPm62xRawHfhVNQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3718c1637caso694299f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803566; x=1724408366;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoDzLJGjLd7vC+WnknkQjgT7+H9CRmytRbPgbaD5W3w=;
        b=tfurjeT7WxAZ8/PDJ63BUM5TIOaLbluvu8x9RTi6p5EIDUCznNYNxheOuqfY5SuzGG
         o297cJxCUTLDc9j98GEu3LU8TsSR8hdZSohpvjOjFziDYiM09n9RwwGaugM1mVN9i8v6
         WBhAY/qWk+te2E+YOmPQjOAKBjvfreZBYaGMHVvCxAv/UGYd3S3LboOKsJPn2DZgr4iG
         WVFpZEZOFijW2R/3Ydic5QTkjLEeUW3HaZZMjVq2YiqQKauDFHI/e9Na/UJJKz2Ibi6P
         uVg2m4n1rKyg17QY/ZIv1clJXb15htrJR6s7+Kz3xVcc7fU2AhPpVszjSWT77AQJ4BPg
         n4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9HR7mFTfj9PpU+Dqj5b2n4wDZ7PiIGFlF7cIKQfb1Hc09+iqXDXJorp8MXDaxsD1cBP8bWa9dlaAk4I+sDNGvLUSDf5mza94EfjU5
X-Gm-Message-State: AOJu0YwxQ0kJylrN3nJkSSqZjDpUoThbiOSVrdC4nCqxEuxJTMUPy+7c
	bexwGMwf6Y48ckWCbVeYK30Hsx5mjAVFXXOo0diT8LNn2G6cnP+h7x321kRUUtg1Jt/eMq7zQci
	ZSmWgjV0yKXZNIAczgnH3K0oQH/o9dwMqrhdklfpc0TrqcfbfP197GYMLahdUnA==
X-Received: by 2002:adf:b1c8:0:b0:371:8682:467e with SMTP id ffacd0b85a97d-371946a50fdmr1256336f8f.46.1723803565929;
        Fri, 16 Aug 2024 03:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuJnhuI+vLEqELwsgHwcwqAmj2E/F4QMFHAmpwK5Hkye+NXTlsDqPHLLrs3goEqNA35dX/+g==
X-Received: by 2002:adf:b1c8:0:b0:371:8682:467e with SMTP id ffacd0b85a97d-371946a50fdmr1256316f8f.46.1723803565156;
        Fri, 16 Aug 2024 03:19:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa229sm3299709f8f.88.2024.08.16.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:19:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 13/25] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
In-Reply-To: <20240814120655.GA1412760@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqphRBrI4mlSdER4@localhost.localdomain>
 <20240814120655.GA1412760@neeraj.linux>
Date: Fri, 16 Aug 2024 12:19:23 +0200
Message-ID: <xhsmhbk1sdb2s.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/08/24 17:36, Neeraj Upadhyay wrote:
>
> I have updated it here [1]. Please let me know if something looks
> incorrect.
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=next.14.08.24a&id=cfc22b9f1572b137dd9f36da831dd7b69c9fe352
>
> - Neeraj

LGTM, thank you for making the changes!


