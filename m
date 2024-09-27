Return-Path: <linux-kernel+bounces-342169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAAB988B30
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3F1F237C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A31C2DB9;
	Fri, 27 Sep 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K0TndU6t"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52F1C1AB8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468461; cv=none; b=keRdNI6XSZ1jnjoTWaAN8HrA2TndZUM0/1PCbi5jGmRKSSa+DEqaQ0OYynQVJjHjt0ojOeATr3VOrSyTMnUJaTukjIse51rWTKKuyIzvOfLQ1rrlQTiz2t8rsKGxpYAuyxaDAzXJwLC1BKvsjxeFiGTxyUxKPW9OdnHZSd1vZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468461; c=relaxed/simple;
	bh=WyXyJQKs+LjNjZ1/xEp2xiqyDBoSLBN/sYzZZZJzDC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYIrLXfTVQ6wtBSiHmp+2AUYuFitRiZ8rnlu5rlzxlwk4CVsPHqr73RD23X5+4YuMq4dAVUyc6AjsIpl0bypsPvExYzOVhmhFJlzcxBFPLldGUGmn/gljTFV0ZZjZdm0zMugXK+/01tK8UFyzdWB73uyIqK9d032GuMjPr6UFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K0TndU6t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so324798566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727468458; x=1728073258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FhWlefZWZpkZ1hQiUXN4BLRYQqUrk3MN5sPdZxTFvf8=;
        b=K0TndU6tl1SHydr5actHDOf9HshzSzDUW03+9Ai7NylmGgTFBS6Xtx2jZdoHsELVNx
         a+nS/BXI7eOve7u9v03+/x0Ces/aOo+1IbuzUqBolfqdjk4NA+cfvFwsIn2DOIqj/zh9
         WOsIrJr0bmBG3LBlxjl7VnJ/uCxtkRlCYFWe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468458; x=1728073258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhWlefZWZpkZ1hQiUXN4BLRYQqUrk3MN5sPdZxTFvf8=;
        b=nciTdwnlPDnamb6zmTl3O9EWxjzG3nz5+Vj8xGyabXrAJmCPU6nVkINy+qhYi1zS3+
         XfIzyttwD7ANlTuAPCFfdrBNlqIGKZRgqiqBiaupq+bli1bzw26WPoN5lLI5bud//nPb
         m/jUX4uoMLM5MNtZPLwnT0+ba+IHMcesDWKGJgiMjgwHykEWxvtKMLf+dYOH4INn7iH2
         4veoybikXSn8VPswLsJ1YXOifD6mPCp+aCPrizkIw10y3BjwlVJwm/fkrNTFgsuwKjrq
         mX3nT76ZXpFx9pOu8P4x/3b0fZpKEBNkAne+BVerUHpEOXrXTjS9EpZdLl7sAvP0aN2D
         QFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx97LNwhB70vHGnSJxmDXagiCeFdKpAmnqMphXNduIdJXDQSK90PCFP1OZM8WGv++ItbJHhwu97q7+buc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVcAod3RtPISvq6gasbnU3y3ie54lTbnysbX1v5n4v7np3oSB
	TtKekjF7EE+Q5/7PkQj2WXHloStyoNyrWczFaprkXFKpk2DNlh9m8kVznJnfqc/lrePjZw/yDSx
	S5Brvqg==
X-Google-Smtp-Source: AGHT+IGln+osLU7oXf41FMHfSthVDWaT9S89y/SKGhKBjP+VMlbfbblPgfIb6N6xZEyiju1dXVT/KQ==
X-Received: by 2002:a17:907:7203:b0:a7a:9447:3e8c with SMTP id a640c23a62f3a-a93c48f9378mr394699966b.3.1727468457849;
        Fri, 27 Sep 2024 13:20:57 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5954sm170169666b.61.2024.09.27.13.20.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 13:20:56 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a83562f9be9so257295366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:20:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeBooVA9YLLju/UQvf1JakMvy8Ewys94h2AE0aQiRR/9BX6xV7GRLPNH/03xSyQQZgbAFL5Io/5WyNOPY=@vger.kernel.org
X-Received: by 2002:a17:907:9604:b0:a8d:250a:52b2 with SMTP id
 a640c23a62f3a-a93c48f95c8mr413441866b.6.1727468454777; Fri, 27 Sep 2024
 13:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
 <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com>
 <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
 <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com> <20240927201522.GW3550746@ZenIV>
In-Reply-To: <20240927201522.GW3550746@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 13:20:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBApKY+1s7F7AB0ZnKs=SSG8jv2LMtay_MY-ym+oEKUg@mail.gmail.com>
Message-ID: <CAHk-=wjBApKY+1s7F7AB0ZnKs=SSG8jv2LMtay_MY-ym+oEKUg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Leo Stone <leocstone@gmail.com>, 
	syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 13:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, what do you prefer for "please run this script with this explanation
> just before -rc1" kind of stuff?

Well, I didn't miss that one either (see commit cb787f4ac0c2:
"[tree-wide] finally take no_llseek out") but yes, it's probably
better to mark those kinds of things very obviously too (and a
'[PATCH-for-linus]' like subject line is probably good there too).

And hey, people will forget, and I'll - mostly - figure it out anyway,
so it's not like this is a big worry. Maybe if you notice that I
missed something, you can make sure that the re-send has a big neon
sign for me.

               Linus

