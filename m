Return-Path: <linux-kernel+bounces-192007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532868D1726
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CBFB25421
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371113DDCE;
	Tue, 28 May 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNujpjTx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902D13D2B6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887920; cv=none; b=VY/IaL159snS/aGi5Bk4Z2Px26A8V/kOmpdkc5FtrbG0EMm+jNBsNNvnv/GTUHcmNn73hSQdQD9ZWsmkjx58D1CaUWL3semAzbJGxx0vvUxxxRzk26Eo5keWa6tf5H8sN6UMdlcoCUg/jyGbnzGI/e905GCi4NZpz6BNq56WHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887920; c=relaxed/simple;
	bh=2F/mo2WDzaQW6C2ZAM3/M+Fb/tJqcO0PUGS4DUgpA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5JQ6GZiKrT3uCP4+2dctEpeSSqmanyVSmnMa3gx2dSCWmiRtjBMky5HJSq6BbE4fv+cUMcbRwTTIRMlmoErPs0s8qLy9rt+TunpF6qBVMmgA1EW+1cLVWRx+9KR7tWBToUpSNvkbIK0guCYaUCraBIpEvkfGmf8hJe54yDBmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNujpjTx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716887917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF2VHywssduunP+Z6gsdQkqjFggocJO3TA5NC7P5wKE=;
	b=dNujpjTxKXKaym7nYZ45fP1THuCd3Pw9pnXWFDwcL8roJPCIqWUdtYpzPcuPtDepek3B/L
	JL14K8H5woOLDrx/sZ695RkDspxmo83cLwyKX+3TDZKUGc4BLz9zgTom3En2VzB1Ygz6RB
	Fwjhqg+7CFDcTkeOrZXVDSBrXgsobpc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-s57wUi4qOM6ElkWW8y4R_w-1; Tue,
 28 May 2024 05:18:35 -0400
X-MC-Unique: s57wUi4qOM6ElkWW8y4R_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51F4829AA382;
	Tue, 28 May 2024 09:18:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C59032026D68;
	Tue, 28 May 2024 09:18:32 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: yongqin.liu@linaro.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set to down/up
Date: Tue, 28 May 2024 11:18:30 +0200
Message-ID: <20240528091831.13674-1-jtornosm@redhat.com>
In-Reply-To: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
References: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello Yongqin,

> When I tried the down and up operations manually from the command line,
> it worked.
> But it only worked after I ran the down and up operations after the boot.
> It fails to work by default after the boot for both the fresh deployment,
> and for the later reboot
Ok, so it works as well for you after the initialization.

> One thing I noticed is that the following message was printed twice
>     "ax88179_178a 2-3:1.0 eth0: ax88179 - Link status is: 1"
> after I ran the up operation,
>
> Is that expected?
> 
> For details, please check the log here:
> https://gist.github.com/liuyq/be8f5305d538067a344001f1d35f677b
That is another thing that I am analyzing, to clean those spurious.
But they are appearing in my case too, and I am not modifying anything at
boot time.

> The scripts are simple, here are the two scripts for Android build:
>    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/ethaddr.rc
>    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/set_ethaddr.sh
>
> Is the one to run the down/change mac/up operations script.
>
> Not sure why the up in the script does not work, but works when run manually.
Ok, I am not working with Android but it doesn't seem spscial, the only
doubt is when the script is executed, if the driver initialization is
complete, ...
Anyway, I will try to reproduce here and analyze it.

Best regards
José Ignacio


