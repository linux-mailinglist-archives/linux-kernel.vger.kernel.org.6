Return-Path: <linux-kernel+bounces-554410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB874A59761
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A41889142
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6622B8B8;
	Mon, 10 Mar 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kwgCcwKQ"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863722AE7E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616397; cv=none; b=nU4NltVSX/fRuDx9kATAgcfTnc1tqX0ExK4dKUWeo0mVr6sb3xx8z7UVPO2U9kfDg6V6eHc58Ugc1Vz7sZqaIVvXi7KrhY3vNQ1yMom3KOJoTevDSnXQ9pzTRkvi4Ydn7h7q02aH2KeBM+WDDpuCVuH0fut77Ez64ARWWGCn+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616397; c=relaxed/simple;
	bh=KWu8zDSYCkOIHDj4bVHZMVBK5paBYHLwqNrwSoppf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdF35jp2C1EyyHr7PQJdWSTUxWZ/JnEJe+ubQ61s4uFMHZQZTHmUuvLLS8OX7doZBWtDXPNs8LQ2HpzXFJrEo6eunQiad5mX/8sWf6U6WFOndVe7UYIySq+vCfbhnTcK1f1zgC/pxLzk0tTu84OdUYAHm/1ZoGfoW3BCE27KChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kwgCcwKQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f6970326so32612606d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741616394; x=1742221194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFZo8zPwzqdWQJxqcj4qgZS2PvMRMOgjbkxudd5sQoM=;
        b=kwgCcwKQBSDOOnqPDxaJhqV85i9+y2dtmXgk+H6ogRzo28zdmImbeYfpKYgk1K9jm9
         GOuB02jIMQNJZuTeMNvlYpOhZ2poCRQGAqaKOv4CtZCGWia96Y2stKDUuFqes3ajvF2H
         TU19b48ATv6dAUufi8VvKxySo229qsU/Abd4Tu/wJi7zN+CQfjh7MXuAGcu/yjy0ZdSk
         CmKVG/bcvbjB38SzQ7d9XKpGmzaFFJ4wvA/tGTAOYsQul8iKCwU74Vat0WejCZPGVcpt
         j7kwiYKL9sOlqO7l/iCN75E4PRWZJOorKQYM/jfa50aZ53LG0NdJPYJ3hhYYM0IlZEeE
         Gtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616394; x=1742221194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFZo8zPwzqdWQJxqcj4qgZS2PvMRMOgjbkxudd5sQoM=;
        b=Ew/6lA3GGil5mI7FdPbWCOBBbK5HoQad1KAIp62xFe50P5ZuLTUh2qERYDrSYSIVPy
         erGuZwCnnLfIqI1q/xQOTdlJe6U7yJbexsbD7PKUTMyUNWRtBOhYQNoQB1xFLn6vNKxc
         QHju3wGx1sYvPyiVcaiQmu1QE8iZKYobv6IhQWTGXsC6u+Nc+z0GOTGpiZbTpRTdWjh4
         WUkoq/vzdabHXpJ/t7M20y3GoQn0DxyrhwD1ivh6DX4xvAfnYd2Qi3xKySuAJFxj02Xi
         e7dRq4KjoBa/e8ZqE9LKxS6ZKCsxxOPW9VsfrRBhoUZk3IiTOLJoI8ApMlwlR/yfb3kK
         coXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3jhJ6z/HZYn9ssdrD9qipBZC2iTY9PIP5FDoxUzBispq84YxsNMfBMk2w5VAqmyz+KFi9v2mW3ZP1ojw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5UyP1TrAThdZjhz6QH3oR9pp12h04cUeRFiQHTQenRAYtjZQ
	Ha/+NqBJ7gvMW4uaG+eaqxrnLF517tmHQPptUMzK/sFBlbx7u9XgVS2KSukDLcI=
X-Gm-Gg: ASbGncvVDZec0TKgCf7sUMjuKWgA01FNtBpCiik3WEftiyDH3PxN8vDduQN4FrwHEZb
	scJvwYSy8iBjLm3u7ciQCgTkL5qHbz6aNlHguB7JGu57UIuktqkLXTGsXsFB6Ta46sCwI65uT5l
	pAiqg/yk3nplOuMYk7lp+vG4h9jKTw+Lv1hGXTNlE9BLQytjyst0tVlq71PVbkrQ2lr64roxWrk
	zuCqHtqzUHfQKk6nBNN0EMqiDgXbjDf3MX9Ye13cC7tHfQdPqQN193X6oFC8tPu+gvbyrezpvPc
	dfKiIUVqR7R9LVRNuulIs6bu13iNr/sHiKNrsoc9XwqadF+6JvVZjdsnY8xLbje2gJhLaZ6SQri
	IKYQywd/a/VLbsHZMsEH+CgXHzbs=
X-Google-Smtp-Source: AGHT+IGMJpR5j6TAtQib68qhOoxtIvV+O/W/i3w2HAax+rxX7rMLW1/8B437NQlpd0ajBQv1DIt3fQ==
X-Received: by 2002:ad4:5d49:0:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6e9006ba2fbmr185600916d6.45.1741616393666;
        Mon, 10 Mar 2025 07:19:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c4cbsm58904436d6.22.2025.03.10.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:19:53 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:19:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z871B9WVRaeIYuOs@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <Z87CuDBMeIcPIWvV@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87CuDBMeIcPIWvV@phytium.com.cn>

On Mon, Mar 10, 2025 at 06:45:12PM +0800, Yuquan Wang wrote:
> On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> > 
> > Platform / BIOS / EFI Configuraiton
> > ===================================
> > ---------------------------------------
> > Step 1: BIOS-time hardware programming.
> > ---------------------------------------
> > 
> > I don't want to focus on platform specifics, so really all you need
> > to know about this phase for the purpose of MM is that platforms may
> > program the CXL device heirarchy and lock the configuration.
> > 
> This question can be very naive, what's the meaning of 'MM' here?
> 

Memory Management - linux/mm

> And since I am not familiar with cxl bios configurations, based on my
> understanding of its acpi results, there are roughly two configuration
> schemes in my analysis: a) users should enter some configuration
> information manually (like region base/size). b) bios could provide a
> recommendatory configuration by device information.
> 

The BIOS must produce ACPI tables to set aside system physical memory
address space.  *How* BIOS produces these ACPI tables (CEDT + SRAT vs
CEDT only) dictates whether this configuration is static or dynamic.

The devices will provide a CDAT (coherent device attribute table) used
by BIOS to generate these ACPI tables.

All of this dictates how linux configures its NUMA topology, programs
CXL HDM decoders, and how it associates device physical memory with numa
nodes and such.

~Gregory

