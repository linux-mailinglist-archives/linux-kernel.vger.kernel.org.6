Return-Path: <linux-kernel+bounces-417731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCBB9D5878
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28451B2212B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8615853D;
	Fri, 22 Nov 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXnQsJKw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31B200A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732245301; cv=none; b=oYeqUMmdRE76GXk2WEQtv0Uw30OhX4mbvDcOdHtnG1P7J4J4Hkc5iWGDVErpwnS9Zmlbq0iTwx1w6V1PPNmYGbBwuKzpY9yJW9PAgOyfxTyIiSeyckCnXua1BlrMjg+FUK8x6Lt6znbosQCKGFPbPx8d0fWxGtQPWSeNZ//pVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732245301; c=relaxed/simple;
	bh=7HHjH1ZUZ1lg1lJsT7TZAs2UFC4QcgRu/sE4VMzGLK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of0SzB8rrBR8VncicXU/5Kxq+6LVnd8uPNVAeNv/Hgy1GNs8x/bnY6eI9X6twg3AKsb49KR8S4WM2tETZMZgb8r+gg0qQGT71rAhZjKk5HpdQG15jqurruWoqv6WUkvjdQzlwaK2dtuJv8wI/V4VRhAUE4rLIDDuUb1KahDB840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXnQsJKw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732245298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HHjH1ZUZ1lg1lJsT7TZAs2UFC4QcgRu/sE4VMzGLK4=;
	b=YXnQsJKw16dXegBGUPwLnryCKjrb6XbP+Z8ZR3iX7ELkR5HKC3iOFq/cuNhIPxpz4Kwf2K
	q4/yqXi/CXTDm0VfHES9Dzdpw5bLENYvxKUAEwhTF8iYhqSk7YrVk5QoTLo5vMDN7d9iek
	iPYHI10GNTTaL8s46gMa7mwO53vJbWk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ZDiuuwKnMyWAX-vBowKgXQ-1; Thu, 21 Nov 2024 22:14:56 -0500
X-MC-Unique: ZDiuuwKnMyWAX-vBowKgXQ-1
X-Mimecast-MFC-AGG-ID: ZDiuuwKnMyWAX-vBowKgXQ
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53da4ff1673so1352844e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732245294; x=1732850094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HHjH1ZUZ1lg1lJsT7TZAs2UFC4QcgRu/sE4VMzGLK4=;
        b=vPN3J0VcZkc5Cb/RqP0of1jDPcJst3JmB/lIehKFgTwsp1mKtAVmAG20oLyFvaJrJa
         KbZJiQ9Vfg+j8hllvpf8KG614jHP0D09ZKejKpKMhbAWy+0s7JIc1+KypLixFWd0Tl0q
         vTuCKY0MfRpSJxSIU9HTwyUbuhx9RNafRC3DQ1h08ncZy8qJPghV0X74VTlZMYvQi7bd
         wuUTytNtoty54lR6OBvHTAuOOG4x54twz9qz4C9etaWFJSMiO3RKvIvD6GQnjbbzo4W9
         cO3qOKJfu1aO1nnhwyDLAUX3S0A1FF81pi7S+nxnQaA7/cKFsWhADvWDknJid/cziLR8
         SIzg==
X-Forwarded-Encrypted: i=1; AJvYcCXPUI+O1ek7ON7FapxdhCTPbUsiB81tVxkt0K124AS+0HDp3PIvjRATDthvlffx+DwEysEi+YLAW2Etc5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tun7mlIzlhFjwuUCJStQjRWS/bWAWc+Uq55387UnkDHRwOlx
	v7iDCKvu2DOWG2DK+YoHRURoQMn75fQI46+fz81yAW2jsdtIz1WEcRNV3QCnA60NNj2z2EHlbTE
	xlAiDWWrvc6GOAPIJsXU/1CnPVYcGqcnc++aDWzYz9pLeV/adU326sojVmJwlCM9xxXTss3QCn0
	WXM5/D8OG+yVSmc5bePhOwr7K6/XoAzpgPPsrgGnoX7tzyt1s=
X-Gm-Gg: ASbGncvKodsotFnM6IIsbkYzgUVIdUiQMePVmqU3F4Urc/LSNt0hIxo2nakwepLbR9n
	Aum0ZUOYkiEgb3gv6/F1nDKBaZqsHtE3Q
X-Received: by 2002:ac2:4c4b:0:b0:53d:a24c:5c7 with SMTP id 2adb3069b0e04-53dc614d3a9mr1643657e87.10.1732245294170;
        Thu, 21 Nov 2024 19:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX6GI/3zJ5hvdmvo0PlFiwxO986ih9KjwCntiVr9+Vl+/jdjr3hI80vJL43VWModZJKppO5g8lp7zhHKSGMD4=
X-Received: by 2002:ac2:4c4b:0:b0:53d:a24c:5c7 with SMTP id
 2adb3069b0e04-53dc614d3a9mr1643651e87.10.1732245293845; Thu, 21 Nov 2024
 19:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118114157.355749-1-yukuai1@huaweicloud.com>
 <20241118114157.355749-6-yukuai1@huaweicloud.com> <CALTww28JrdXoNXQNPxx2Sg9L2iL20jZZ80Y-qZzqcyF780M1fg@mail.gmail.com>
 <e6843d53-c7f4-2e38-0a15-91b49afec8f1@huaweicloud.com>
In-Reply-To: <e6843d53-c7f4-2e38-0a15-91b49afec8f1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 22 Nov 2024 11:14:42 +0800
Message-ID: <CALTww28ZRFo6BwqzriVpoOuqbfygKrU0HuOhhUxLe9cBBDY-ZQ@mail.gmail.com>
Subject: Re: [PATCH md-6.13 5/5] md/md-bitmap: move bitmap_{start, end}write
 to md upper layer
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 10:46=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2024/11/22 10:06, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, Nov 18, 2024 at 7:44=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> There are two BUG reports that raid5 will hang at
> >> bitmap_startwrite([1],[2]), root cause is that bitmap start write and =
end
> >> write is unbalanced, and while reviewing raid5 code, it's found that
> >
> > Hi Kuai
> >
> > It's better to describe more about "unbalanced" in the patch. For
> > raid5, bitmap is set and cleared based on stripe->dev[] now. It looks
> > like the set operation matches the clear operation already.
>
> Ok, one place that I found is that raid5 can do extra end write while
> stripe->dev[].towrite is NULL, the null checking is missing. I'll
> mention that in the next version.

Does this can cause the deadlock?

Regards
Xiao

>
> ...
>
> >
> > This patch looks good to me.
> >
> > Reviewd-by: Xiao Ni <xni@redhat.com>
> >
>
> Thanks for the review. I'll also remove the unused STRIPE_BITMAP_PENDING
> in v2.
>
> Kuai
>
> >
> > .
> >
>


