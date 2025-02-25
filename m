Return-Path: <linux-kernel+bounces-530818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C308BA438E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC4419E0068
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58B17F7;
	Tue, 25 Feb 2025 09:04:45 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7018BB9C;
	Tue, 25 Feb 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474284; cv=none; b=MfkO0b+KdzSMq3Hic3wAt+9tuEvJ8Ooxik8bVhB+jMLLGQaZEgWFhkSkaYgg4JoT4csbiRz8CvZklmwSeUmVMmMY4EdrhijbrOQEPSC02pCFEsMaPBshZwNdmBQSkgE7ZdQ0UwtWzODJoUEqBrCtdMsV96OQyIxPeUjhxyhtnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474284; c=relaxed/simple;
	bh=qKfVtuQYYK46bbyotNANakW1TEPcNNUrJw04XqoOn4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HApdBfpWDeGFqBs+2KuILm9gdC5Od0aGVB4VhmbHHo0i7jVtfZLVS56aJtfaLuuu2WmYiW6RnwnjQ2wEi/pLXYo26AA+AiFP/MUTqhwtx6pb51s8QaFqfDLPvnMImBwzMrUSJ+TPH8scmGO5e+D7xcuslGpTloCIae76EaUw4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z2BQV5xLfz1ltcQ;
	Tue, 25 Feb 2025 17:00:34 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 01BDE1401E9;
	Tue, 25 Feb 2025 17:04:37 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Feb 2025 17:04:24 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Feb 2025 17:04:23 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux@roeck-us.net>, <jdelvare@suse.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [RFC] hwmon: (acpi_power_meter) Replace hwmon_device_register
Date: Tue, 25 Feb 2025 16:51:58 +0800
Message-ID: <20250225085158.6989-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

When load this mode, we can see the following log:
"power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
 convert the driver to use hwmon_device_register_with_info()."

So replace hwmon_device_register with hwmon_device_register_with_info.

To avoid any changes in the display of some sysfs interfaces, some of
necessary changes in hwmon.c must be made:
1> For 'power1_average_interval_max/min' interface, insert 'average' to the
   string corresponding to hwmon_power_average_interval_max/max in
   hwmon_power_attr_templates[]. I guess that is what's missing.
2> Add some string attributes in power sensor type because of below items:
   a) power1_accuracy  --> display like '90.0%'
   b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
   c) power1_average_min/max --> display 'unknown' when its value is
                                 negative.
Note: All the attributes modified above in hwmon core are not used by other
drivers.

Please note that the path of these sysfs interfaces are modified
accordingly if use hwmon_device_register_with_info():
old: all sysfs interfaces are under acpi device.
now: all sysfs interfaces are under hwmon device.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
Hi all,

This patch is aimed to replace a deprecated interface this driver used.
The biggest difficulty is how to avoid ABI changes.
Welcome to join the discussion.
  
---
 drivers/hwmon/acpi_power_meter.c | 782 ++++++++++++++-----------------
 drivers/hwmon/hwmon.c            |  13 +-
 2 files changed, 362 insertions(+), 433 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 44afb07409a4..4c7641cd46c3 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -87,25 +87,12 @@ struct acpi_power_meter_resource {
 	bool		power_alarm;
 	int			sensors_valid;
 	unsigned long		sensors_last_updated;
-	struct sensor_device_attribute	sensors[NUM_SENSORS];
-	int			num_sensors;
 	s64			trip[2];
 	int			num_domain_devices;
 	struct acpi_device	**domain_devices;
 	struct kobject		*holders_dir;
 };
 
-struct sensor_template {
-	char *label;
-	ssize_t (*show)(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf);
-	ssize_t (*set)(struct device *dev,
-		       struct device_attribute *devattr,
-		       const char *buf, size_t count);
-	int index;
-};
-
 /* Averaging interval */
 static int update_avg_interval(struct acpi_power_meter_resource *resource)
 {
@@ -124,62 +111,6 @@ static int update_avg_interval(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t show_avg_interval(struct device *dev,
-				 struct device_attribute *devattr,
-				 char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-
-	mutex_lock(&resource->lock);
-	update_avg_interval(resource);
-	mutex_unlock(&resource->lock);
-
-	return sprintf(buf, "%llu\n", resource->avg_interval);
-}
-
-static ssize_t set_avg_interval(struct device *dev,
-				struct device_attribute *devattr,
-				const char *buf, size_t count)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	int res;
-	unsigned long temp;
-	unsigned long long data;
-	acpi_status status;
-
-	res = kstrtoul(buf, 10, &temp);
-	if (res)
-		return res;
-
-	if (temp > resource->caps.max_avg_interval ||
-	    temp < resource->caps.min_avg_interval)
-		return -EINVAL;
-	arg0.integer.value = temp;
-
-	mutex_lock(&resource->lock);
-	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
-				       &args, &data);
-	if (ACPI_SUCCESS(status))
-		resource->avg_interval = temp;
-	mutex_unlock(&resource->lock);
-
-	if (ACPI_FAILURE(status)) {
-		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PAI",
-					     status);
-		return -EINVAL;
-	}
-
-	/* _PAI returns 0 on success, nonzero otherwise */
-	if (data)
-		return -EINVAL;
-
-	return count;
-}
-
 /* Cap functions */
 static int update_cap(struct acpi_power_meter_resource *resource)
 {
@@ -198,61 +129,6 @@ static int update_cap(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t show_cap(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-
-	mutex_lock(&resource->lock);
-	update_cap(resource);
-	mutex_unlock(&resource->lock);
-
-	return sprintf(buf, "%llu\n", resource->cap * 1000);
-}
-
-static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	int res;
-	unsigned long temp;
-	unsigned long long data;
-	acpi_status status;
-
-	res = kstrtoul(buf, 10, &temp);
-	if (res)
-		return res;
-
-	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	if (temp > resource->caps.max_cap || temp < resource->caps.min_cap)
-		return -EINVAL;
-	arg0.integer.value = temp;
-
-	mutex_lock(&resource->lock);
-	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
-				       &args, &data);
-	if (ACPI_SUCCESS(status))
-		resource->cap = temp;
-	mutex_unlock(&resource->lock);
-
-	if (ACPI_FAILURE(status)) {
-		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_SHL",
-					     status);
-		return -EINVAL;
-	}
-
-	/* _SHL returns 0 on success, nonzero otherwise */
-	if (data)
-		return -EINVAL;
-
-	return count;
-}
-
 /* Power meter trip points */
 static int set_acpi_trip(struct acpi_power_meter_resource *resource)
 {
@@ -287,34 +163,6 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	unsigned long temp, trip_bk;
-	int res;
-
-	res = kstrtoul(buf, 10, &temp);
-	if (res)
-		return res;
-
-	temp = DIV_ROUND_CLOSEST(temp, 1000);
-
-	guard(mutex)(&resource->lock);
-
-	trip_bk = resource->trip[attr->index - 7];
-	resource->trip[attr->index - 7] = temp;
-	res = set_acpi_trip(resource);
-	if (res) {
-		resource->trip[attr->index - 7] = trip_bk;
-		return res;
-	}
-
-	return count;
-}
-
 /* Power meter */
 static int update_meter(struct acpi_power_meter_resource *resource)
 {
@@ -341,202 +189,6 @@ static int update_meter(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t show_power(struct device *dev,
-			  struct device_attribute *devattr,
-			  char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-
-	mutex_lock(&resource->lock);
-	update_meter(resource);
-	mutex_unlock(&resource->lock);
-
-	if (resource->power == UNKNOWN_POWER)
-		return -ENODATA;
-
-	return sprintf(buf, "%llu\n", resource->power * 1000);
-}
-
-/* Miscellaneous */
-static ssize_t show_str(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	acpi_string val;
-	int ret;
-
-	mutex_lock(&resource->lock);
-	switch (attr->index) {
-	case 0:
-		val = resource->model_number;
-		break;
-	case 1:
-		val = resource->serial_number;
-		break;
-	case 2:
-		val = resource->oem_info;
-		break;
-	default:
-		WARN(1, "Implementation error: unexpected attribute index %d\n",
-		     attr->index);
-		val = "";
-		break;
-	}
-	ret = sprintf(buf, "%s\n", val);
-	mutex_unlock(&resource->lock);
-	return ret;
-}
-
-static ssize_t show_val(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	u64 val = 0;
-	int ret;
-
-	guard(mutex)(&resource->lock);
-
-	switch (attr->index) {
-	case 0:
-		val = resource->caps.min_avg_interval;
-		break;
-	case 1:
-		val = resource->caps.max_avg_interval;
-		break;
-	case 2:
-		val = resource->caps.min_cap * 1000;
-		break;
-	case 3:
-		val = resource->caps.max_cap * 1000;
-		break;
-	case 4:
-		if (resource->caps.hysteresis == UNKNOWN_HYSTERESIS)
-			return sprintf(buf, "unknown\n");
-
-		val = resource->caps.hysteresis * 1000;
-		break;
-	case 5:
-		if (resource->caps.flags & POWER_METER_IS_BATTERY)
-			val = 1;
-		else
-			val = 0;
-		break;
-	case 6:
-		ret = update_meter(resource);
-		if (ret)
-			return ret;
-		/* need to update cap if not to support the notification. */
-		if (!(resource->caps.flags & POWER_METER_CAN_NOTIFY)) {
-			ret = update_cap(resource);
-			if (ret)
-				return ret;
-		}
-		val = resource->power_alarm || resource->power > resource->cap;
-		resource->power_alarm = resource->power > resource->cap;
-		break;
-	case 7:
-	case 8:
-		if (resource->trip[attr->index - 7] < 0)
-			return sprintf(buf, "unknown\n");
-
-		val = resource->trip[attr->index - 7] * 1000;
-		break;
-	default:
-		WARN(1, "Implementation error: unexpected attribute index %d\n",
-		     attr->index);
-		break;
-	}
-
-	return sprintf(buf, "%llu\n", val);
-}
-
-static ssize_t show_accuracy(struct device *dev,
-			     struct device_attribute *devattr,
-			     char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	unsigned int acc = resource->caps.accuracy;
-
-	return sprintf(buf, "%u.%u%%\n", acc / 1000, acc % 1000);
-}
-
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *devattr,
-			 char *buf)
-{
-	return sprintf(buf, "%s\n", ACPI_POWER_METER_NAME);
-}
-
-#define RO_SENSOR_TEMPLATE(_label, _show, _index)	\
-	{						\
-		.label = _label,			\
-		.show  = _show,				\
-		.index = _index,			\
-	}
-
-#define RW_SENSOR_TEMPLATE(_label, _show, _set, _index)	\
-	{						\
-		.label = _label,			\
-		.show  = _show,				\
-		.set   = _set,				\
-		.index = _index,			\
-	}
-
-/* Sensor descriptions.  If you add a sensor, update NUM_SENSORS above! */
-static struct sensor_template meter_attrs[] = {
-	RO_SENSOR_TEMPLATE(POWER_AVERAGE_NAME, show_power, 0),
-	RO_SENSOR_TEMPLATE("power1_accuracy", show_accuracy, 0),
-	RO_SENSOR_TEMPLATE("power1_average_interval_min", show_val, 0),
-	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
-	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
-	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
-			   set_avg_interval, 0),
-	{},
-};
-
-static struct sensor_template misc_cap_attrs[] = {
-	RO_SENSOR_TEMPLATE("power1_cap_min", show_val, 2),
-	RO_SENSOR_TEMPLATE("power1_cap_max", show_val, 3),
-	RO_SENSOR_TEMPLATE("power1_cap_hyst", show_val, 4),
-	RO_SENSOR_TEMPLATE(POWER_ALARM_NAME, show_val, 6),
-	{},
-};
-
-static struct sensor_template ro_cap_attrs[] = {
-	RO_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, 0),
-	{},
-};
-
-static struct sensor_template rw_cap_attrs[] = {
-	RW_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, set_cap, 0),
-	{},
-};
-
-static struct sensor_template trip_attrs[] = {
-	RW_SENSOR_TEMPLATE("power1_average_min", show_val, set_trip, 7),
-	RW_SENSOR_TEMPLATE("power1_average_max", show_val, set_trip, 8),
-	{},
-};
-
-static struct sensor_template misc_attrs[] = {
-	RO_SENSOR_TEMPLATE("name", show_name, 0),
-	RO_SENSOR_TEMPLATE("power1_model_number", show_str, 0),
-	RO_SENSOR_TEMPLATE("power1_oem_info", show_str, 2),
-	RO_SENSOR_TEMPLATE("power1_serial_number", show_str, 1),
-	{},
-};
-
-#undef RO_SENSOR_TEMPLATE
-#undef RW_SENSOR_TEMPLATE
-
 /* Read power domain data */
 static void remove_domain_devices(struct acpi_power_meter_resource *resource)
 {
@@ -638,107 +290,362 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
 	return res;
 }
 
-/* Registration and deregistration */
-static int register_attrs(struct acpi_power_meter_resource *resource,
-			  struct sensor_template *attrs)
+static int set_trip(struct acpi_power_meter_resource *resource, u32 attr,
+		    unsigned long trip)
 {
-	struct device *dev = &resource->acpi_dev->dev;
-	struct sensor_device_attribute *sensors =
-		&resource->sensors[resource->num_sensors];
-	int res = 0;
+	unsigned long trip_bk;
+	int ret;
 
-	while (attrs->label) {
-		sensors->dev_attr.attr.name = attrs->label;
-		sensors->dev_attr.attr.mode = 0444;
-		sensors->dev_attr.show = attrs->show;
-		sensors->index = attrs->index;
+	trip = DIV_ROUND_CLOSEST(trip, 1000);
 
-		if (attrs->set) {
-			sensors->dev_attr.attr.mode |= 0200;
-			sensors->dev_attr.store = attrs->set;
-		}
+	guard(mutex)(&resource->lock);
 
-		sysfs_attr_init(&sensors->dev_attr.attr);
-		res = device_create_file(dev, &sensors->dev_attr);
-		if (res) {
-			sensors->dev_attr.attr.name = NULL;
-			goto error;
-		}
-		sensors++;
-		resource->num_sensors++;
-		attrs++;
+	trip_bk = resource->trip[attr - hwmon_power_average_max];
+	resource->trip[attr - hwmon_power_average_max] = trip;
+	ret = set_acpi_trip(resource);
+	if (ret)
+		resource->trip[attr - hwmon_power_average_max] = trip_bk;
+
+	return ret;
+}
+
+static int set_cap(struct acpi_power_meter_resource *resource,
+		   unsigned long cap)
+{
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+	unsigned long long data;
+	acpi_status status;
+
+	cap = DIV_ROUND_CLOSEST(cap, 1000);
+	if (cap > resource->caps.max_cap || cap < resource->caps.min_cap)
+		return -EINVAL;
+	arg0.integer.value = cap;
+
+	guard(mutex)(&resource->lock);
+	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
+				       &args, &data);
+	if (ACPI_FAILURE(status)) {
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_SHL",
+					     status);
+		return -EINVAL;
 	}
+	resource->cap = cap;
 
-error:
-	return res;
+	/* _SHL returns 0 on success, nonzero otherwise */
+	if (data)
+		return -EINVAL;
+
+	return 0;
 }
 
-static void remove_attrs(struct acpi_power_meter_resource *resource)
+static int set_avg_interval(struct acpi_power_meter_resource *resource,
+			    unsigned long val)
 {
-	int i;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+	unsigned long long data;
+	acpi_status status;
 
-	for (i = 0; i < resource->num_sensors; i++) {
-		if (!resource->sensors[i].dev_attr.attr.name)
-			continue;
-		device_remove_file(&resource->acpi_dev->dev,
-				   &resource->sensors[i].dev_attr);
+	if (val > resource->caps.max_avg_interval ||
+	    val < resource->caps.min_avg_interval)
+		return -EINVAL;
+	arg0.integer.value = val;
+
+	guard(mutex)(&resource->lock);
+	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
+				       &args, &data);
+	if (ACPI_FAILURE(status)) {
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PAI",
+					     status);
+		return -EINVAL;
 	}
+	resource->avg_interval = val;
 
-	remove_domain_devices(resource);
+	/* _PAI returns 0 on success, nonzero otherwise */
+	if (data)
+		return -EINVAL;
 
-	resource->num_sensors = 0;
+	return 0;
 }
 
-static int setup_attrs(struct acpi_power_meter_resource *resource)
+static int get_power_alarm_state(struct acpi_power_meter_resource *resource,
+				 long *val)
 {
-	int res = 0;
+	int ret;
 
-	/* _PMD method is optional. */
-	res = read_domain_devices(resource);
-	if (res && res != -ENODEV)
-		return res;
+	ret = update_meter(resource);
+	if (ret)
+		return ret;
 
-	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
-		res = register_attrs(resource, meter_attrs);
-		if (res)
-			goto error;
+	/* need to update cap if not to support the notification. */
+	if (!(resource->caps.flags & POWER_METER_CAN_NOTIFY)) {
+		ret = update_cap(resource);
+		if (ret)
+			return ret;
 	}
 
-	if (resource->caps.flags & POWER_METER_CAN_CAP) {
-		if (!can_cap_in_hardware()) {
-			dev_warn(&resource->acpi_dev->dev,
-				 "Ignoring unsafe software power cap!\n");
-			goto skip_unsafe_cap;
+	*val = resource->power_alarm || resource->power > resource->cap;
+	resource->power_alarm = resource->power > resource->cap;
+
+	return 0;
+}
+
+static umode_t power_meter_is_visible(const void *data,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
+{
+	const struct acpi_power_meter_resource *res = data;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_power_average:
+	case hwmon_power_accuracy:
+	case hwmon_power_average_interval_min:
+	case hwmon_power_average_interval_max:
+		if (res->caps.flags & POWER_METER_CAN_MEASURE)
+			return 0444;
+		break;
+	case hwmon_power_average_interval:
+		if (res->caps.flags & POWER_METER_CAN_MEASURE)
+			return 0644;
+		break;
+	case hwmon_power_cap_min:
+	case hwmon_power_cap_max:
+	case hwmon_power_cap_hyst:
+	case hwmon_power_alarm:
+		if (res->caps.flags & POWER_METER_CAN_CAP && can_cap_in_hardware())
+			return 0444;
+		break;
+	case hwmon_power_cap:
+		if (res->caps.flags & POWER_METER_CAN_CAP && can_cap_in_hardware()) {
+			if (res->caps.configurable_cap)
+				return 0644;
+			else
+				return 0444;
 		}
+		break;
+	case hwmon_power_average_min:
+	case hwmon_power_average_max:
+		if (res->caps.flags & POWER_METER_CAN_TRIP)
+			return 0x644;
+		break;
+	default:
+		break;
+	}
 
-		if (resource->caps.configurable_cap)
-			res = register_attrs(resource, rw_cap_attrs);
-		else
-			res = register_attrs(resource, ro_cap_attrs);
+	return 0;
+}
 
-		if (res)
-			goto error;
+static int power_meter_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	int ret = 0;
 
-		res = register_attrs(resource, misc_cap_attrs);
-		if (res)
-			goto error;
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	guard(mutex)(&res->lock);
+
+	switch (attr) {
+	case hwmon_power_average:
+		ret = update_meter(res);
+		if (ret)
+			return ret;
+		if (res->power == UNKNOWN_POWER)
+			return -ENODATA;
+		*val = res->power * 1000;
+		break;
+	case hwmon_power_average_interval_min:
+		*val = res->caps.min_avg_interval;
+		break;
+	case hwmon_power_average_interval_max:
+		*val = res->caps.max_avg_interval;
+		break;
+	case hwmon_power_average_interval:
+		ret = update_avg_interval(res);
+		if (ret)
+			return ret;
+		*val = (res)->avg_interval;
+		break;
+	case hwmon_power_cap_min:
+		*val = res->caps.min_cap * 1000;
+		break;
+	case hwmon_power_cap_max:
+		*val = res->caps.max_cap * 1000;
+		break;
+	case hwmon_power_alarm:
+		ret = get_power_alarm_state(res, val);
+		if (ret)
+			return ret;
+		break;
+	case hwmon_power_cap:
+		ret = update_cap(res);
+		if (ret)
+			return ret;
+		*val = res->cap * 1000;
+		break;
+	default:
+		break;
 	}
 
-skip_unsafe_cap:
-	if (resource->caps.flags & POWER_METER_CAN_TRIP) {
-		res = register_attrs(resource, trip_attrs);
-		if (res)
-			goto error;
+	return 0;
+}
+
+static int power_meter_read_string(struct device *dev,
+				   enum hwmon_sensor_types type, u32 attr,
+				   int channel, const char **str)
+{
+#define POWER_METER_MAX_READ_STR_LENGTH		32
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	static char buf[POWER_METER_MAX_READ_STR_LENGTH];
+	u64 val;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(buf));
+	guard(mutex)(&res->lock);
+
+	switch (attr) {
+	case hwmon_power_accuracy:
+		sprintf(buf, "%llu.%llu%%\n", res->caps.accuracy / 1000,
+			res->caps.accuracy % 1000);
+		*str = buf;
+		break;
+	case hwmon_power_cap_hyst:
+		if (res->caps.hysteresis == UNKNOWN_HYSTERESIS)
+			sprintf(buf, "unknown\n");
+		else
+			sprintf(buf, "%llu\n", res->caps.hysteresis * 1000);
+		*str = buf;
+		break;
+	case hwmon_power_average_min:
+	case hwmon_power_average_max:
+		if (res->trip[attr - hwmon_power_average_max] < 0) {
+			sprintf(buf, "unknown\n");
+		} else {
+			val = res->trip[attr - hwmon_power_average_max] * 1000;
+			sprintf(buf, "%llu\n", val);
+		}
+		*str = buf;
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	res = register_attrs(resource, misc_attrs);
-	if (res)
-		goto error;
+	return 0;
+}
 
-	return res;
-error:
-	remove_attrs(resource);
-	return res;
+static int power_meter_write(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long val)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	int ret;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_power_average_max:
+	case hwmon_power_average_min:
+		ret = set_trip(res, attr, val);
+		break;
+	case hwmon_power_cap:
+		ret = set_cap(res, val);
+		break;
+	case hwmon_power_average_interval:
+		ret = set_avg_interval(res, val);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static const struct hwmon_channel_info * const power_meter_info[] = {
+	HWMON_CHANNEL_INFO(power, HWMON_P_ACCURACY | HWMON_P_AVERAGE |
+		HWMON_P_AVERAGE_INTERVAL | HWMON_P_AVERAGE_INTERVAL_MIN |
+		HWMON_P_AVERAGE_INTERVAL_MAX | HWMON_P_CAP | HWMON_P_CAP_MIN |
+		HWMON_P_CAP_MAX | HWMON_P_CAP_HYST | HWMON_P_ALARM |
+		HWMON_P_AVERAGE_MIN | HWMON_P_AVERAGE_MAX),
+	NULL
+};
+
+static const struct hwmon_ops power_meter_ops = {
+	.is_visible = power_meter_is_visible,
+	.read = power_meter_read,
+	.read_string = power_meter_read_string,
+	.write = power_meter_write,
+};
+
+static const struct hwmon_chip_info power_meter_chip_info = {
+	.ops = &power_meter_ops,
+	.info = power_meter_info,
+};
+
+static ssize_t power1_is_battery_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n",
+			  res->caps.flags & POWER_METER_IS_BATTERY ? 1 : 0);
+}
+
+static ssize_t power1_model_number_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", res->model_number);
+}
+
+static ssize_t power1_oem_info_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", res->oem_info);
+}
+
+static ssize_t power1_serial_number_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", res->serial_number);
+}
+
+static DEVICE_ATTR_RO(power1_is_battery);
+static DEVICE_ATTR_RO(power1_model_number);
+static DEVICE_ATTR_RO(power1_oem_info);
+static DEVICE_ATTR_RO(power1_serial_number);
+
+#define POWER_EXTRA_BATTERY_ATTR_IDX	3
+static struct attribute *power_extra_attrs[] = {
+	&dev_attr_power1_model_number.attr,
+	&dev_attr_power1_oem_info.attr,
+	&dev_attr_power1_serial_number.attr,
+	&dev_attr_power1_is_battery.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(power_extra);
+
+static void update_power_extra_groups(struct acpi_power_meter_resource *res)
+{
+	power_extra_attrs[POWER_EXTRA_BATTERY_ATTR_IDX] =
+			(res->caps.flags & POWER_METER_CAN_MEASURE) ?
+			&dev_attr_power1_is_battery.attr : NULL;
 }
 
 static void free_capabilities(struct acpi_power_meter_resource *resource)
@@ -848,13 +755,24 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 	case METER_NOTIFY_CONFIG:
 		mutex_lock(&resource->lock);
 		free_capabilities(resource);
+		remove_domain_devices(resource);
+		hwmon_device_unregister(resource->hwmon_dev);
 		res = read_capabilities(resource);
-		mutex_unlock(&resource->lock);
 		if (res)
-			break;
-
-		remove_attrs(resource);
-		setup_attrs(resource);
+			dev_err_once(&device->dev, "read capabilities failed.\n");
+		res = read_domain_devices(resource);
+		if (res && res != -ENODEV)
+			dev_err_once(&device->dev, "read domain devices failed.\n");
+		update_power_extra_groups(resource);
+		resource->hwmon_dev =
+			hwmon_device_register_with_info(&device->dev,
+							ACPI_POWER_METER_NAME,
+							resource,
+							&power_meter_chip_info,
+							power_extra_groups);
+		if (IS_ERR(resource->hwmon_dev))
+			dev_err_once(&device->dev, "register hwmon device failed.\n");
+		mutex_unlock(&resource->lock);
 		break;
 	case METER_NOTIFY_TRIP:
 		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
@@ -928,11 +846,15 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	resource->trip[0] = -1;
 	resource->trip[1] = -1;
 
-	res = setup_attrs(resource);
-	if (res)
+	/* _PMD method is optional. */
+	res = read_domain_devices(resource);
+	if (res && res != -ENODEV)
 		goto exit_free_capability;
 
-	resource->hwmon_dev = hwmon_device_register(&device->dev);
+	update_power_extra_groups(resource);
+	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev, ACPI_POWER_METER_NAME,
+						    resource, &power_meter_chip_info,
+						    power_extra_groups);
 	if (IS_ERR(resource->hwmon_dev)) {
 		res = PTR_ERR(resource->hwmon_dev);
 		goto exit_remove;
@@ -942,7 +864,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	goto exit;
 
 exit_remove:
-	remove_attrs(resource);
+	remove_domain_devices(resource);
 exit_free_capability:
 	free_capabilities(resource);
 exit_free:
@@ -961,7 +883,7 @@ static void acpi_power_meter_remove(struct acpi_device *device)
 	resource = acpi_driver_data(device);
 	hwmon_device_unregister(resource->hwmon_dev);
 
-	remove_attrs(resource);
+	remove_domain_devices(resource);
 	free_capabilities(resource);
 
 	kfree(resource);
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9703d60e9bbf..4f1af2ed091a 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -483,12 +483,19 @@ static ssize_t hwmon_attr_store(struct device *dev,
 	return count;
 }
 
+static bool power_is_string_attr(u32 attr)
+{
+	return attr == hwmon_power_label || attr == hwmon_power_accuracy ||
+		attr == hwmon_power_cap_hyst || attr == hwmon_power_average_min ||
+		attr == hwmon_power_average_max;
+}
+
 static bool is_string_attr(enum hwmon_sensor_types type, u32 attr)
 {
 	return (type == hwmon_temp && attr == hwmon_temp_label) ||
 	       (type == hwmon_in && attr == hwmon_in_label) ||
 	       (type == hwmon_curr && attr == hwmon_curr_label) ||
-	       (type == hwmon_power && attr == hwmon_power_label) ||
+	       (type == hwmon_power && power_is_string_attr(attr)) ||
 	       (type == hwmon_energy && attr == hwmon_energy_label) ||
 	       (type == hwmon_humidity && attr == hwmon_humidity_label) ||
 	       (type == hwmon_fan && attr == hwmon_fan_label);
@@ -646,8 +653,8 @@ static const char * const hwmon_power_attr_templates[] = {
 	[hwmon_power_enable] = "power%d_enable",
 	[hwmon_power_average] = "power%d_average",
 	[hwmon_power_average_interval] = "power%d_average_interval",
-	[hwmon_power_average_interval_max] = "power%d_interval_max",
-	[hwmon_power_average_interval_min] = "power%d_interval_min",
+	[hwmon_power_average_interval_max] = "power%d_average_interval_max",
+	[hwmon_power_average_interval_min] = "power%d_average_interval_min",
 	[hwmon_power_average_highest] = "power%d_average_highest",
 	[hwmon_power_average_lowest] = "power%d_average_lowest",
 	[hwmon_power_average_max] = "power%d_average_max",
-- 
2.22.0


