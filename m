Return-Path: <linux-kernel+bounces-423245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F19DA4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F00416255D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58C193416;
	Wed, 27 Nov 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CisYtDZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E9193060
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700336; cv=none; b=XN/pNRS2e3DzfcDEjQHg3D4FfvjNgHhxul60w/bpkKS548yYMrbD3Vpn37nj1ZD5Ts44BmPuiOpmkZ//I7fuhcoepgOQ1O+LDnpBBe47pdj8sKXJ7WS/CZ0eVZ4zE6esK6dhdqXNgUouFRRPiEYB80XmX2TyeVxp8IrehH5K2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700336; c=relaxed/simple;
	bh=k+0grmfi/B62i6ByVqGUgDScCl7uFtwldM0WMpITXog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6yf9QO4n4qzH1fBqy6hx/JrwssIs8k4uXzPkOBdKeFXKQCW9Tbs7QrKrIigTmikRA5JHVAmpZxCUxjY3PbF/aMJNfaoUNTcz2YZN10MFeo6RFz/Z7Vx2W7BpM8PERiudeKcKPko7lYxGJM29oobCHlrZvqj6ipaf0DnqXja6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CisYtDZ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732700333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67mCCAfGGkUPbab4Ey3Mf6PbNpI7TD0NLALRxHnve6g=;
	b=CisYtDZ+JXeYPTiXgYK3ITK2TIIXP86YzTX15s9174SmC06FIXndxwlw0Xwc+RoZaMx52U
	vZOve+M/5VmKFCHyEFx+wnhRjSv6XaSsd8cs0HxAk9njjXyPUznNcdA94jLxCU3z1zKZt8
	TCvBS6Rf/Wo3jb3Aa4pzSTHBooucZko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-rPVw4JQfOQWgrBumNf5GMw-1; Wed, 27 Nov 2024 04:38:52 -0500
X-MC-Unique: rPVw4JQfOQWgrBumNf5GMw-1
X-Mimecast-MFC-AGG-ID: rPVw4JQfOQWgrBumNf5GMw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a27c9044so15509545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700331; x=1733305131;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67mCCAfGGkUPbab4Ey3Mf6PbNpI7TD0NLALRxHnve6g=;
        b=ie0kzcm5JsA8Ck/nINVf/2dTK9G8IeGMn8VxyrEzHeQt7dDZvZw9h9IaRs7BXAlux6
         TXXtom4dQ2siciHqpkllmifFyOwjjlHaiu9NsOpFnxS7pizIhHU7mb99cUkREN/AP9Jk
         SxC9qIl/uP9BQwegYrmjQfzHifuacdVOK4pdOdK9zBhVUi1iNDNi0TGbmD53n6H8zTW5
         RkbEq5HPvf4sbAKgqqVs19slaOxfaLzdOQnqN+D4eB/1H0e2DJhPeWw9qcbwURAigjhu
         11PSVLOeuVbxeEtwrwgCjaBqO9R5I+KmPiM0MSFqjmuVpF98IBWzdmb0iEfAqcz/6wuS
         rUiQ==
X-Gm-Message-State: AOJu0YyzUS5hSYxaG51aFPiBeDcadgP83c3bC6+ek8Qja9uPWxTtYbON
	426LahuSdLEFEBGVy9MhWUNYDPxQe5HcC6lFnBtrWh7Ir7z5iROhXL+tzR+W2EXeVzUIkhKje5z
	oHu/JtYlgYkhumLLdCY9qp/ONLV05j5KhtYe/KASOMt9FxJoaLZFZfgI0LZUsmg==
X-Gm-Gg: ASbGnctCn4wZ5osWFRumW/72RlA9WnLaOvaOyPUKhpryRzjO1KE65c8CobWykmE3dl2
	naePvC//Y/k3NBXrBXggu/0SjCWpUmRPMuXuu8JXbAV1xNfQ3rXwF/7g/xXAvhhqAPIFLJUQwZv
	fWZkl8Os2/sxMFjA5O4U9O/aU48+R9rdjzi6bBOzdjbVnG1TF4J5iZdzQgI/lB+w6QbZ1qxbGX1
	QpUMIcB60g8+i+VoQLJfd2gGDf2hRPQbUWAzLeREPIKIAEOKUes6lBKrj7aNewN+K/gUb0RvrRa
	WLHSU+pbKz3K9YYk5ibBQlGFxnmCL8BvZmQ=
X-Received: by 2002:a05:600c:1e1b:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-434a9de819fmr18274995e9.25.1732700330814;
        Wed, 27 Nov 2024 01:38:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpw5sbzbayfkp2I3fg5d6Vm3hbz5XaDjeKpgIB9kIlyiTJ7IXEY3Iom1ISrm0/6zWt9y8akA==
X-Received: by 2002:a05:600c:1e1b:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-434a9de819fmr18274835e9.25.1732700330467;
        Wed, 27 Nov 2024 01:38:50 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa6f3d11sm15832935e9.0.2024.11.27.01.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:38:49 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/3] objtool: noinstr validation for static
 branches/calls
In-Reply-To: <cover.1732682344.git.jpoimboe@kernel.org>
References: <cover.1732682344.git.jpoimboe@kernel.org>
Date: Wed, 27 Nov 2024 10:38:49 +0100
Message-ID: <xhsmh34jdnhhy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 26/11/24 20:47, Josh Poimboeuf wrote:
> v2:
> - Add some fixes reported by kbuild.
>
>
> FWIW, this reports the following static keys:
>
>   - sched_clock_running
>   - __sched_clock_stable
>   - mds_idle_clear
>   - vmx_l1d_flush_cond
>   - stack_erasing_bypass
>
> and the following static calls:
>
>   - pv_sched_clock
>   - x86_idle
>

And you event did the static calls, sweet! Thanks a ton Josh, lemme catch
up with emails and then I'll look into these.


