Return-Path: <linux-kernel+bounces-329145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E0978E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3F51F24C21
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC309374C3;
	Sat, 14 Sep 2024 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpO1WWzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953D1758E
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726292334; cv=none; b=MJyOIeePhstE5bCMl0ubGseJs2v14IJLrM3tx90gddeZ6Vc74ToJUxbV8R03ujHiz3xMLTYQD9M+uKWR7d0DAuSWv4j5C3prPDL1Z+XGtOhi/eIF0bVb96aDYCP8iYP2UyRQNmJ6kJHia/mBzgzK+TdxQG5jWuaZStPcbNow/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726292334; c=relaxed/simple;
	bh=UlVn8fWFgP8yf3muvfLEqiwH/WZRlUZiVMyShTuifUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anJ3jJXVimoeCylhknOrP/zGZpKZ+w52Tmd82DGYOKAnu3lzwJzvlaRKnbOZIbMjkkSFmpRUg6bNLhT4ReJzQ3yGE3MsUcWeqiJZzHZAt/yssT1QkmW0uOPiaEbWnLbdEsb9e4g0g7vw6nyyM4IRPzv9mjb2cv18y+QetwDKS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpO1WWzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7547C4CEC0;
	Sat, 14 Sep 2024 05:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726292333;
	bh=UlVn8fWFgP8yf3muvfLEqiwH/WZRlUZiVMyShTuifUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XpO1WWzYHYTwRtLfZGl4iOOc7d+02PCfjEXlKJgaPkkWLX5jvtsyvdEICyVPR88fz
	 1CLcPeREenOMSbsiVjC1eCVSNLpfRMm6OuAh7FVMzqV6IAj6TPakHA7AByFGg6mO2C
	 C4eqLv5pOy4s+wcWUiFCgd38TC6kczItyDizuNPEOlAn3KJWn4NyOmyOvQLnFVXGc+
	 5m2ERtBlScH1IwFeTDHnVF5Uhyoj7uZxI70kwpLOww07a411ZzUpKU8k3QwpVzcefB
	 2c+eY7LsP/CG6jUGv9zMFt4DzlfCrZKxySKF9JwcKLvFYJbkHgBH2KtcJQ9tIq0isO
	 Lo9HaYdhEumLg==
Date: Sat, 14 Sep 2024 07:38:48 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240914073848.7b8bd8f0@foz.lan>
In-Reply-To: <20240913142802.08571a15@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
	<20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
	<20240825052923.715f88bc@sal.lan>
	<20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
	<20240911163436.00004738@Huawei.com>
	<20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
	<20240913072025.76a329b0@foz.lan>
	<20240913111300.00007a3c@Huawei.com>
	<20240913142802.08571a15@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Sep 2024 14:28:02 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > > 5. Just return an error code without doing any resets. To me, this is 
> > >    the worse scenario.
> > > 
> > > I don't like (5), as if something bad happens, there's nothing to be
> > > done.    
> > 
> > If it happens on a real system nothing is done either. So I'm not sure
> > we need to handle that.  Or maybe real hardware reinjects the interrupt
> > if the OSPM hasn't done anything about it for a while.
> >   
> > > 
> > > For QMP error injection (4) seems is overkill. It may be needed in the
> > > future if we end implementing a logic where host OS informs guest about
> > > hardware problems, and such errors use asynchronous notifications.
> > > 
> > > I would also avoid implementing (3) at least for now, as reporting
> > > such error via QMP seems enough for the QMP usecase.
> > > 
> > > So, if ok for you, I'll change the code to (2).    
> > 
> > Whilst I don't feel strongly about it, I think 5 is unfortunately the
> > correct option if we aren't going to queue errors in qemu (so make it
> > an injection tool problem).  
> 
> +1 to option (5)

Ok, will do (5) then.

Thanks,
Mauro

