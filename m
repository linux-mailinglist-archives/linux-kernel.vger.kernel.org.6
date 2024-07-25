Return-Path: <linux-kernel+bounces-262357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C593C515
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3262F1C21DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DF11E89C;
	Thu, 25 Jul 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMgznN66"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9D1E895
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918816; cv=none; b=GvDJ53iVYZfyFbTPuzdauk6GvmbXdeQujcqy8sLy/2/QmB60s4IcNLIy3MtHeYlKCKAggEsyLzdGDA4ajKGIJ4ZdJqFuy/efAxbGW7eNfA2CvWHAQvahFZTD/iOfM/Fum7SGZclkKWFzMD/S5sw23VqqBXgTVZSEb83L1L1VbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918816; c=relaxed/simple;
	bh=UXpXmJvT0va0l3p81se0HFl/LbI/kH9FMntWyqrkBcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e6kHESstI5l5tJl0cn8sb0bTjIeEULStMJiB3CTknJdiz9/PNftI3QZMOpUAeZr6CcIjCSlcxBnVqgSaMtlS3fq82PSZ4m2dEoZRGTWN8IpO6UrwA+MweAf2qt3q11WZJ1Vd19jFEBuc8vKZNdg4RRLoi56G3hFd+0dexxwyE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMgznN66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721918812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpXmJvT0va0l3p81se0HFl/LbI/kH9FMntWyqrkBcg=;
	b=aMgznN66Yxmw4KC+WYXZsDvrzgb3ADaTsq8tZidAwhddM6KTh8UT90tt9Msgwp1kllEX8r
	8dlx1GSLtjRTA+/LSMTyK1KAyRdWunvitiZnGguxaNeK7Ymx7GKUPVQkUm5KZ7CPpIG02V
	j1SH1t4iNO7n1UIzJHwFnbmS1Q31biI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-JFyNhCs_MNuwtuLayFAuRA-1; Thu, 25 Jul 2024 10:46:47 -0400
X-MC-Unique: JFyNhCs_MNuwtuLayFAuRA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367990b4beeso611250f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918806; x=1722523606;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXpXmJvT0va0l3p81se0HFl/LbI/kH9FMntWyqrkBcg=;
        b=RKWXYIIVTB0DUa+qJdLUfJ+ygMm5PhAKSkTBq39wwo6Eqnjbd+NKMoTAbAOPK3SNLw
         bMy4ZFP6lsE084m1O+/9gSDjePKcrr/vI4HbFL8whU/NYaqu/2aLHFeH4MsWp/HOVnWv
         FXTYKlnfavmH4POWeLE5A9NvKPiCPQPkqxE+qVmP1emmXlWq417ZmLEvk8/S3DoZKGTT
         jL4wn9s8TqYtPJnaLwLDJz+g3L97K0oc7iDTgygVC3PonhifX+VwNng/7AxUZHU7BISA
         NmFZLtCKAw3Cbbna07te2PUXJETPPKRCFF/0x60ww6s4idFrKo0Y7Ft0QeOZVw3uE4Pz
         WWkg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2LjoN/v9SirQ3qRQi7LuKTfHFlgtUn2152hugNoJ0ZOrwQbJQvLlnl1Eq4V8TaLg6nXWbBWh/lOPHJWtd7gzj0wD8IMTlNlVyxiU
X-Gm-Message-State: AOJu0YyoANVF116oM021JaJ3myD5u8WuZvMrIL42ZYZHhUBEFkjeTckB
	epZc1yG0QbUj/FieldugzPrfaJ0m4RaFB2v7eHC5IZ2ADVKgZSEv2agu+1h9XYsMhozcPOLkF0i
	Pt++cEeo3PooafDKlAip14ZFlv+/CTAlQDs4ClbnrKpnu+AylFYKjJxTvoL1jfw==
X-Received: by 2002:adf:e281:0:b0:366:e64f:b787 with SMTP id ffacd0b85a97d-36b319dbda9mr2129994f8f.8.1721918805889;
        Thu, 25 Jul 2024 07:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK86Bkeo6mGzPN+xwCuZD5Bq8Yc6ON5LsThd8oveDep2INDu56QbTBosMfiRiBF84C7tMKtg==
X-Received: by 2002:adf:e281:0:b0:366:e64f:b787 with SMTP id ffacd0b85a97d-36b319dbda9mr2129978f8f.8.1721918805511;
        Thu, 25 Jul 2024 07:46:45 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d5asm2414743f8f.84.2024.07.25.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:46:44 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 14/25] context_tracking, rcu: Rename
 rcu_dynticks_curr_cpu_in_eqs() into rcu_watching_curr_cpu()
In-Reply-To: <ZqJAwZiJ3oC-Kr36@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-15-vschneid@redhat.com>
 <ZqJAwZiJ3oC-Kr36@localhost.localdomain>
Date: Thu, 25 Jul 2024 16:46:43 +0200
Message-ID: <xhsmhcyn1zfzg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/07/24 14:10, Frederic Weisbecker wrote:
> Le Wed, Jul 24, 2024 at 04:43:14PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
>> RCU_WATCHING, reflect that change in the related helpers.
>>
>> Note that "watching" is the opposite of "in EQS", so the negation is lif=
ted
>> out of the helper and into the callsites.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> You may need to update the patch title on this one.
>

Duh, there's a few of these, sorry about & thanks for spotting them.

> Thanks.


