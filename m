Return-Path: <linux-kernel+bounces-202567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25278FCE18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A100D1C23F47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0B1B142B;
	Wed,  5 Jun 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBJpB1n4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE01B1409
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589737; cv=none; b=p9qYg04o3rVC92GoaxydXpiMH/FgJuQ4O39IejEDjP8UkplTAgrIVUYJYedhhdH1oA8K2yF4HS0KDoxKEhXxEfPnNBreHop8CtwWBv1T9U6QOGx0NO+zZ9tMshf5PMJUSt6A5aAGcJImYAZnP5sVx8t7QTaIU/ELM5dsoEs9Hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589737; c=relaxed/simple;
	bh=aBH7ZGzhHtOrFlhInedXq6fvNVbijOKk0r2q29+BYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlU0wY1KnkO4oS3GWoq3KfWMwmpLa6244CfKGbGwJpMzFeqDXaRGaixefGJqYiYADpcWYpGptbKo0dOTXWofAh9yppFqU6Cu+lXpqnEH2SXyP0blK0BGrFt0orFJypwdGEQnV1lBLet6xteCj57czBuuWGsRkEBm398KH8fKlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBJpB1n4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717589734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FX3I2i3kNCLrNugmkBn/vfBWlVnprvDuDoaVhXjiOw4=;
	b=QBJpB1n4uFbLkEfrmt6/6uBbFgNJkp/hGEqn4cvZqMOnQbTlUvV2VCf0Npg2h8MG8RE/z/
	Nr3cmV0l4/WyPDmvQA1CxUuUdGKhLQxigwnIzAjEAhXpasy6Jn/QTCce4n7PsA1JwAoCer
	AOEXOoVvlbPtb3ydboIhfFYtH7Lr3iw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-KUHP3BDGP3KFzxHz-X1CwA-1; Wed, 05 Jun 2024 08:15:33 -0400
X-MC-Unique: KUHP3BDGP3KFzxHz-X1CwA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-794b02ec662so266188585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589732; x=1718194532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX3I2i3kNCLrNugmkBn/vfBWlVnprvDuDoaVhXjiOw4=;
        b=QrehCwT1Fk6yRvaPoMszfyzlS+ergwcrfhTzZuI2B3fNw8Un/tPtMIaHQUXZrA6g9H
         0uvWWYIi7QlXBJU44oz6mr/ti8+UJi++k53ZhPjpCfzuwAWrncPalsWz4bKb/M5wTSfX
         klfQiQ1KjyZ3CfvTLeeJKmUkZHBcxk/hwSY7BuvcCqsbjwix5cqqYELrW4fcBAj0BTZ5
         uZtXrfFvaA+D/+uKxOaHIX5N9R42rZCu8UtHBSHbucgpQ6l54x6iXZZeXH/udz8CYbGa
         lbn+GVjpEWLByWka0SayTzNM5FY4RfX4O1QDjBn4CBjBMO2iG+TnZmIj3/Kgv+VNMSQA
         BMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPPPDGh99HSj27l/sHkRvUqe8URm36NU3Fw7JfGGGHTdSiGp8kW/KYs2slb/SP2r5CjVsjWOgZQg2MPfAhP2le8MbWPLhZby0JAD+q
X-Gm-Message-State: AOJu0YzrgrCx1crQlS22dc3xLBGNi1FQS4tLbRWjjqEjz2e7AderzAgx
	hVCI8WZs3pkJtA0pCY1VGpnBfecbYh7SBp+/SmWQ4leH4brMgq1G3xorfSoqnLaN43cOr+P9cm1
	QtEAn1HFr8DdKUSx6ePcmg7qKRnpHRm9FwON34F9SMEIrBMi7R4Y9pFDCbV5l8CB9X9gg+g==
X-Received: by 2002:a05:620a:4953:b0:795:1b03:c595 with SMTP id af79cd13be357-79523fd637bmr212229085a.69.1717589731936;
        Wed, 05 Jun 2024 05:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdRf4S8UBCyuSDbfrKO5AKfrzX/7ifuufee10AyBqFng+4PBUkSJ05UPf2W093ZP6faibyzQ==
X-Received: by 2002:a05:620a:4953:b0:795:1b03:c595 with SMTP id af79cd13be357-79523fd637bmr212227585a.69.1717589731572;
        Wed, 05 Jun 2024 05:15:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f317073fsm439471085a.112.2024.06.05.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:15:31 -0700 (PDT)
Date: Wed, 5 Jun 2024 14:15:27 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH linux-next] printk: nbcon: Fix
 nbcon_cpu_emergency_flush() when preemptible
Message-ID: <ZmBW3-j2f-pNdIzT@jlelli-thinkpadt14gen4.remote.csb>
References: <87zfrzvhsp.fsf@jogness.linutronix.de>
 <ZmA5oIkImclKM0vx@pathway.suse.cz>
 <ZmA6oGrO1YVF-IYj@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmA6oGrO1YVF-IYj@pathway.suse.cz>

On 05/06/24 12:14, Petr Mladek wrote:
> On Wed 2024-06-05 12:10:50, Petr Mladek wrote:
> > On Wed 2024-06-05 11:57:34, John Ogness wrote:
> > > nbcon_cpu_emergency_flush() can be called in a preemptible
> > > context. In that case the CPU is not in an emergency state.
> > > However, in order to see that the CPU is not in an emergency
> > > state (accessing the per-cpu variable), preemption must be
> > > disabled.
> > > 
> > > Disable preemption when checking the CPU state.
> > > 
> > > Reported-by: Juri Lelli <juri.lelli@redhat.com>
> > > Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
> > > Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
> > > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > 
> > Great catch!
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > I am going to push it...
> 
> Juri, should/could I add your Tested-by ?

A yes please if you like. Thanks!

Tested-by: Juri Lelli <juri.lelli@redhat.com>

You guys were so quick to act on it! :)

Best,
Juri


