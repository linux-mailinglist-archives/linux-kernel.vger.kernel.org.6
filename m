Return-Path: <linux-kernel+bounces-424039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D09DAFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD4D281C89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECA19408C;
	Wed, 27 Nov 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUjAXzII"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A59433C8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749694; cv=none; b=VkYSYRVAkOCITLOQYfjTAeI78m/5LwWs1pGX2fmWQJ/uqD7Zgc0acUwr3eD4760H5lHviJV+qie+F+BSsVLABWkpHd/SFomBdCT1Df5N/jfOVCesFdJEPp9PdvET1AjBqwSleADWB0NajUO2NCi/wwttw3nH0OvLsoDP6RWwS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749694; c=relaxed/simple;
	bh=+jPnjmSkIWnfw1ypNxPAHk3jExZky9QC/KYnqBebpVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJZ44jDE7TdehHJ6ULDTrgQQCDgO3ML6NnxYic1TmmIHBgbIWJ9GCtYKqG8Mo2JAfJhWbNxujBr8bBoCPvv5joE0IDglHU2C6keGFhi0FUQ4CVUABsI4l6WRVt3NzUuEDA55Kr6a9vQtDBLnb2BcD/uFIqSyBBtKLG6eqnWIigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RUjAXzII; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724e3e4accdso55429b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732749692; x=1733354492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=RUjAXzIIW003Gms51rsvGVyLyLvqqrEFGGA8DN91PPVE4Z0B38Ni3rJNABHIodf0gy
         65UO/SMGTrpGIjbnVbM/1CoN1bJ87wuO8bWoZoH/It01e7oe6Dx4kmDQUh2/cQHxHOUe
         lM9aIV2JUbQof2RyOgzNOX08ocayohJ/ceD/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749692; x=1733354492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=vQaCvBi5uKoAFUxtc0ki+5p+PasA9IEwL8gzYUOqIyjqGcxqtbHwL9TT34MRms62KT
         Oq1M39hZ0J/+J+VU92tQkNN1STAZv30YqXyw+jnctDoE1dpfISXGLQ7WHzQpytsZX5ZT
         9rFKaU4hDmVlpY4OAa5SNHrKOckRSZmrc1VAqVs42gMFzkkE3LbocT0uq1yYgkIeJEmM
         ntodQLqIoQBMyl7DFOVezTKsXEowmmMXkTPBNPSUe3DkZaAZNT9MFgQn5+pAFhkEJYfm
         49WLzW7WIC81QWADELcW1NbAZuzhFxonIt+ndO7HX3+b/uS6j0JweD+9dNGQ85XfLyhj
         t6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCULrDCSXuaMIzrT3pkET2gp1ct1b+GajjEt07gdGlVLadh2w6iDf+d96bGXLjLlpIz4+smV22Npvkn6aCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqB9Q1JbgeE9R7wkIeEsB6+ztnxXpd4JxkL+oxSTAUjpkaDds
	9Ah8g5L0JzlzrIQMifRn6U9qGx65VCzEfCzV2uRMq5FcStP4baCehtrEkoeKQFqrNY6BA5Oyxml
	Zru/h
X-Gm-Gg: ASbGncvNPq70kleGxK3Z4stQqFZT0Pn4Yj3oj7k8qcIjcZLualAklGxP5DZjb+eAV1w
	D2KgZS2O/3aw/zIisygIPh8P2hPsek1nMLII7do2LqaatBV8NIEpKJYACtKGiBuDPb1CT2CNDgc
	Q7H7AueXIkevpiNzmzsDDo3u8bzNMgzOZ2PkoITR7iYeNzAVaCQcD/5C6nuMFPxRokjH0hCrP+c
	sRsHVpjOyzdq5h61VLr062WZeRi9kdC6SttZm1C0f7FjlpXejGYrAI5MIbgFIATDq7n8ukPW98O
	l7efWckRpmxCraDJlw==
X-Google-Smtp-Source: AGHT+IGWf6ubQpf+ReVlT3GBRfhIgFsslShv60urwsdXHiog9KqCG1o/VnSy4dplYcu5xOk5Rxz0aw==
X-Received: by 2002:a17:902:da92:b0:20c:876a:fdac with SMTP id d9443c01a7336-21500ff2226mr25174285ad.0.1732749692476;
        Wed, 27 Nov 2024 15:21:32 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521983547sm975385ad.187.2024.11.27.15.21.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:21:32 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so134209a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:21:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz1ps4DBayIE/zHBTNp3GBhV6eligf7iwQd6IIm+GB6AgRAS2I9ONk6lAH8XpoEutTFp8nVMsiTXgGH34=@vger.kernel.org
X-Received: by 2002:a17:902:f382:b0:212:655c:caf with SMTP id
 d9443c01a7336-21501e5af92mr39560115ad.55.1732749318060; Wed, 27 Nov 2024
 15:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-10-yuanchu@google.com>
In-Reply-To: <20241127025728.3689245-10-yuanchu@google.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 27 Nov 2024 15:14:52 -0800
X-Gmail-Original-Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] virtio-balloon: add workingset reporting
To: Yuanchu Xie <yuanchu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 7:00=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wr=
ote:
[...]
> diff --git a/include/linux/workingset_report.h b/include/linux/workingset=
_report.h
> index f6bbde2a04c3..1074b89035e9 100644
> --- a/include/linux/workingset_report.h
> +++ b/include/linux/workingset_report.h
[...]
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index ee35a372805d..668eaa39c85b 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -25,6 +25,7 @@
>   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
>   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
>   * SUCH DAMAGE. */
> +#include "linux/workingset_report.h"
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  #include <linux/virtio_ids.h>

This seems to be including a non-uapi header
(include/linux/workingset_report.h) from a uapi header
(include/uapi/linux/virtio_balloon.h), which won't compile outside the
kernel. Does anything in the uapi actually need declarations from
workingset_report.h?

> @@ -37,6 +38,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT        3 /* VQ to report free pa=
ges */
>  #define VIRTIO_BALLOON_F_PAGE_POISON   4 /* Guest is using page poisonin=
g */
>  #define VIRTIO_BALLOON_F_REPORTING     5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING  6 /* Working Set Size reporting *=
/
>
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -128,4 +130,32 @@ struct virtio_balloon_stat {
>         __virtio64 val;
>  } __attribute__((packed));
>
> +/* Operations from the device */
> +#define VIRTIO_BALLOON_WS_OP_REQUEST 1
> +#define VIRTIO_BALLOON_WS_OP_CONFIG 2
> +
> +struct virtio_balloon_working_set_notify {
> +       /* REQUEST or CONFIG */
> +       __le16 op;
> +       __le16 node_id;
> +       /* the following fields valid iff op=3DCONFIG */
> +       __le32 report_threshold;
> +       __le32 refresh_interval;
> +       __le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
> +struct virtio_balloon_working_set_report_bin {
> +       __le64 idle_age;
> +       /* bytes in this bucket for anon and file */
> +       __le64 anon_bytes;
> +       __le64 file_bytes;
> +};
> +
> +struct virtio_balloon_working_set_report {
> +       __le32 error;
> +       __le32 node_id;
> +       struct virtio_balloon_working_set_report_bin
> +               bins[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Have the spec changes been discussed in the virtio TC?

Thanks,
-- Daniel

