Return-Path: <linux-kernel+bounces-276509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960B9494BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C481F22A10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69B22EE5;
	Tue,  6 Aug 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HiuSqNt4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2622331
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959065; cv=none; b=H2n8+DZVsKTMXQCQv4e2irVoijBWc3gx9j57sSxW45Ee1VQ5noMYIO84rXpazUUoGWjhJn3pVqgsqdOmrwqY8BAGh7jwgSYEABXwrVGTmW7ZAiLsVT2h3Z1eFv2dv0215bN++y90fF+ZO14ku3NtkDlQg8dI6WQttjvA4pKUloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959065; c=relaxed/simple;
	bh=KgFSWo3vStIxrgJrfreZEBQwN8dmF2anV3qEo7DEyr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp75OUw9SamU8pF90Gsd4nkS58b9eRL/nh5mrW6dJP5Qj+e+6eS9iaqQOh8FTXdnZBo9TfAOBOclcKAhFuuZXrXgfVXp8yn1/+zMW+pmXIZJA5fzoy9xZXKn7fNs03nY+bPK8ItDKYnGSWD09dt8fAstirvdNUkwrhWICUGkHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HiuSqNt4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476FiGtu116462;
	Tue, 6 Aug 2024 10:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722959056;
	bh=KtojXCqXyz1BQEIX2+uZ4MDpfmU9yzBwuTcClQ4bhQ8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HiuSqNt4G5srcfRpFnGeyGvpBhyxuY/7cjw7V/HRDW2p5uMvh4wCvtkVhHAqPd5pL
	 ShSkG3IebsdI6JHtRqIC2rJUhRNAYwoA6R9tQ1lKNz5LGwc+wKBqk/s9XmoGjo2FiO
	 exiC60UdnF0ac1l5JKGzyBU+8EsSAqPjdrbFgd8o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476FiFWm048996
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 10:44:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 10:44:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 10:44:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476FiFAw042908;
	Tue, 6 Aug 2024 10:44:15 -0500
Date: Tue, 6 Aug 2024 10:44:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Akashdeep Kaur <a-kaur@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3] firmware: ti_sci: add CPU latency constraint
 management
Message-ID: <20240806154415.wrsqxgyqdi2y4ae6@candy>
References: <20240802214220.3472221-1-khilman@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240802214220.3472221-1-khilman@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:42-20240802, Kevin Hilman wrote:
> During system-wide suspend, check if any of the CPUs have PM QoS
> resume latency constraints set.  If so, set TI SCI constraint.
> 
> TI SCI has a single system-wide latency constraint, so use the max of
> any of the CPU latencies as the system-wide value.
> 
> Note: DM firmware clears all constraints at resume time, so
> constraints need to be checked/updated/sent at each system suspend.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> Depends on the TI SCI series where support for the constraints APIs
> are added:
> https://lore.kernel.org/r/20240801195422.2296347-1-msp@baylibre.com
> 

Unless there is a reason to maintain this patch separately, Could we
add this to the mentioned series -> it is much easier to review and
merge them in one go.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

